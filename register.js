// Cordova Registry register script
// run with 'node register.js'

var plugman = require('plugman')

plugman.adduser([], function(err) {
    if(err) {
        console.log('error ' + err);
        throw err;
    }else{
        // Publish with path to MAT PhoneGap plugin that does NOT contain node or register scripts
        plugman.publish(['/path/to/plugin'], function(err) {
            if(err) {
                console.log('error ' + err);
                throw err;
            }else{
                console.log('Published!!');
            }
        });
    }
});
