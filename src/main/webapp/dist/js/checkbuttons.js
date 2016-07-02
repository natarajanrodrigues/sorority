/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('#check_todos').click(function () {
    $('.check_marker').not(this).trigger('click');
});

$('.check_marker').change(function () {
    if ($('.check_marker:checked').length === $('.check_marker').length)
        $('#check_todos').prop('checked', true);
    else 
        $('#check_todos').prop('checked', false);
});