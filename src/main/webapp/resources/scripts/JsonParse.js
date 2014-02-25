/**
 * Created by Artwar on 2014-02-18.
 */
var dataModule = [];
function parseJSON(data){
    dataModule = [];
    return JSON.parse(data, function(key, value){

        switch (key){
            case "brand":
            case "category":
            case "product":
            case "store":
            case "user":
                if (isNaN(value)){
                    dataModule.push(value);
                    //console.log([key,value]);
                } else {
                    for(var i = 0; i < dataModule.length; i++){
                        var d = dataModule[i];
                        if (d["@id"] == value){
                            return d
                        }
                    }
                }
                break;
        }
        return value;
    });
}
/*function(key, value){

    switch (key){
        case "brand":
        case "category":
        case "product":
        case "store":
        case "user":
            if (isNaN(value)){
                dataModule.push(value);
                console.log([key,value]);
            } else {
                for(var i = 0; i < dataModule.length; i++){
                    var d = dataModule[i];
                    if (d["@id"] == value){
                        return d
                    }
                }
            }
            break;
    }

    return value;
}   */