/**
 * Created by paulpodolsky on 05/05/14.
 */


var Maelstorm = new function(){
    this.prepareParam = function(name, value) {
        // To prevent xss attacks, a csrf token must be defined as a meta attribute
        csrf_token = jQuery('meta[name=csrf-token]').attr('content');
        csrf_param = jQuery('meta[name=csrf-param]').attr('content');

        var data = "_method=put";
        data += "&" + name + '=' + encodeURIComponent(value);

        if (csrf_param !== undefined && csrf_token !== undefined) {
            data += "&" + csrf_param + "=" + encodeURIComponent(csrf_token);
        }
        return data;
    }
}