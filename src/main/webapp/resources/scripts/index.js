/**
 * Created by Artwar on 2014-02-26.
 */
$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    a.re
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};