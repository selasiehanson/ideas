// Provide the wiring information in a module
angular.module('helpers', []).
  factory('MSG', function($window) {
        var MSG =  {
          msgBox : null,
          msgBoxes : [],
          show : function (message, status, options){
            var status = status ? status: "error";
            options = options || {}

            var wait = options.wait || null;
            var callback = options.callback || null;
            var layout = options.layout || "top";

            var x = noty({
              text: message,
              type:status,
              dismissQueue: true,
              layout: layout,
              theme: 'defaultTheme'
            });


            MSG.msgBoxes.push(x)

            if(callback){
                callback();
            }
            
            if(!wait){
                setTimeout(function (){ 
                if(status !== "error"){
                  MSG.hide()
                }
              },8000);  
            }
            
          }, 
          hide : function (){
            MSG.msgBoxes.forEach(function (box){
                if(box)
                  box.close();
            });
          }
        };
    return MSG;
  }).factory("ARR",function (){
    return {
      sort : function  (arr, fieldToUse) {
        var name  = fieldToUse || "name";
        function compare (a,b) {
          if (a[name] < b[name])
            return -1;
          if (a[name] > b[name])
            return 1;
          return 0;
        }

        return arr.sort(compare);
      }
    }
  }).factory("OBJ",function (){
    return {
      rectify : function (obj,_default) {
        var out = {}
        if(obj){
          for (var i in _default){
            obj[i] = obj[i] || _default[i]
          }

           out = obj;
        }else {
          out = _default;
        }
       return out;
      }
    }
  }).factory("UrlResolver", function (){
    
    return {
      setBasePath : function (basePath){
        this.pathRoot = basePath;
      },
      resolve : function (path){
         //return this.pathRoot + path
         return path;   
        //return window.location.origin + "/jms/public/" + path
      }
    }
  }).factory("DateHelper", function ($filter){
    
    return {
      _default : "dd-mm-yyyy",
      formats : {
        "dd-mm-yyyy" : "dd-MM-yyyy",
        "dd/mm/yyyy" : "dd/MM/yyyy"
      },
      formatDate : function (date, format){
        // console.log(date)
        format = this._default || format;
        var out = $filter('date')(date, this.formats[format]);
        // console.log(out)
        return out;
      }
    }
  });