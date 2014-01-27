var plugman = require('plugman')

plugman.adduser([], function(err) {
    if(err) {
        console.log('error ' + err);
        throw err;
    }else{
        plugman.unpublish(['com.mobileapptracking.matplugin'], function(err) {
            if(err) {
                console.log('error ' + err);
                throw err;
            }else{
                console.log('Unpublished!!');
            }
        });
    }
});
