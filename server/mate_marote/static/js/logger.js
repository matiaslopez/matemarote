/* Remote game log saver
 * requires JSON.js and jQuery
 * Usage:
 * var logger = new Logger('/saving_url/', game_id)
 * logger.log('some_event_name', {'some_arg':'arg_value', 'some_list':[1,2,3,4]})
 * logger.finalize(function(){ alert('game saved'); }, function(){ alert("couldn't save game"); })
 * */
function Logger(url, game_id){
	this.event_list = [], this.order = 0, this.autoflush_interval;
	
	this.log = function(type, data, time){
		/* push an event to the event list.
		 * time is the millisecond the event took place, it can be ommited
		 * if the event occurred at the time this method was called. 
		 * */
		this.event_list.push({type:type, data:data, order: ++this.order,
						 	  time: time || new Date().getTime()});
	}
	
	this.flush = function(success_callback, error_callback, retries){
		/* Flush the log to the server, opts are:
		 * success_callback: called on successful save, or when log was empty
		 * error_callback: called on successful 
		 * retries: integer, retry saving n times, 0 or undefined means no retries 
		 * */
		var to_save = this.event_list;
		this.event_list = [];
		
		function error(){
			this.event_list = to_save.concat(this.event_list);
			if(retries){
				this.flush(success_callback, retries-1);
			}else{
				error_callback && error_callback();
			}
		}
		function success(r){
			if(r.status == 200){
				success_callback && success_callback();
			}else{
				error();
			}
		}
		if(to_save.length){
			$.ajax({url:url, type:'POST', dataType:'json',
					data:{'game_id':game_id, 'log': to_save.map(JSON.encode).join('\n')},
					success: success, error: error})
		}else{
			success_callback && success_callback();
		}
	}
		
	this.start_autoflush = function(){
		var self = this;
		this.autoflush_interval = setInterval(function(){
			self.flush(null, 2);
		}, 5000);
	}
	
	this.stop_autoflush = function(){
		if(this.autoflush_interval){
			clearInterval(this.autoflush_interval);
			this.autoflush_interval = null;
		}
	}
	
	this.finalize = function(success_callback, error_callback, retries){
		this.stop_autoflush();
		this.flush(success_callback, error_callback, retries);
	}
	
	this.start_autoflush();
}