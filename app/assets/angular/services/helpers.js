// Provide the wiring information in a module
angular.module('helpers', []).
 factory("ARR",[function (){
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
 }]).factory("OBJ",[function (){
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
 }])
 .factory("DateHelper", ["$filter",function ($filter){
       
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
     }]);