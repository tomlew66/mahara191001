//self executing function for namespacing code
(function( CustomLayoutManager, $, undefined ) {

    // Public Methods
    CustomLayoutManager.customlayout_add_row = function(pieformname) {
        var numrows = parseInt($('#' + pieformname + '_customlayoutnumrows').val(), 10);
        if ((numrows < get_max_custom_rows()) && (numrows >= 1)) {
            var newid;
            var newrow = $('#customrow_' + numrows).clone();
            var currentncols = $('#customrow_' + numrows).find('#selectnumcolsrow_' + numrows).val();
            var currentcollayout = $('#customrow_' + numrows).find('#selectcollayoutrow_' + numrows).val();
            var labelValue = "<span class='sr-only'>" + get_string("Row", "view") + " " + (numrows + 1) + ": </span>" + get_string_ajax("numberofcolumns", "view");
            var labelValue2 = "<span class='sr-only'>" + get_string("Row", "view") + " " + (numrows + 1) + ": </span>" + get_string_ajax('columnlayout', 'view');

            newrow.find('.customrowtitle').html('<strong>' + get_string('rownr', 'view', numrows + 1) + '</strong>');
            newrow.attr('id', 'customrow_' + (numrows + 1));

            newid = 'selectnumcolsrow_' + (numrows + 1);
            newrow.find('#selectnumcolsrow_' + numrows).val(currentncols);
            newrow.find('#selectnumcolsrow_' + numrows).attr('id', newid);
            newrow.find('label[for="selectnumcolsrow_' + numrows + '"]').attr('for', newid).html(labelValue);

            newid = 'selectcollayoutrow_' + (numrows + 1);
            newrow.find('#selectcollayoutrow_' + numrows).val(currentcollayout);
            newrow.find('#selectcollayoutrow_' + numrows).attr('id', 'selectcollayoutrow_' + (numrows + 1));
            newrow.find('label[for="selectcollayoutrow_' + numrows + '"]').attr('for', newid).html(labelValue2);

            if ((oldremovebutton = $(newrow).find('button')).length != 0) {
                oldremovebutton.attr('class', 'pull-left btn btn-sm btn-default removecustomrow_' + (numrows + 1));
            }
            else {
                // warning: classes are modified above for any subsequent button instances
                newrow.append('<button name="removerow" class="pull-left btn btn-sm btn-default removecustomrow_' + (numrows + 1) + '" onclick="CustomLayoutManager.customlayout_remove_row(\'' + pieformname + '\', this)"><span class="icon icon-lg icon-trash text-danger"></span><span class="hidden-xs pls"> ' + get_string('removethisrow', 'view') + '</span></button>');
            }
            $('#customrow_' + numrows).after(newrow);
            $('#' + pieformname + '_customlayoutnumrows').val(numrows + 1);
            customlayout_change_layout(pieformname);
            newrow.find('select').first().trigger("focus");
        }

        if (parseInt($('#' + pieformname + '_customlayoutnumrows').val(), 10) >= get_max_custom_rows()) {
            $('#addrow').attr('disabled', 'disabled');
        }
    };

    CustomLayoutManager.customlayout_remove_row = function(pieformname, row) {
        var numrows = parseInt($('#' + pieformname + '_customlayoutnumrows').val(), 10);
        $(row).closest('.customrow').remove();
        $('#' + pieformname + '_customlayoutnumrows').val(numrows - 1);
        var inc = 1;
        $('#customrows .customrow').each(function() {
            $(this).find('.customrowtitle').html('<strong>' + get_string('rownr', 'view', inc) + '</strong>');
            $(this).attr('id', 'customrow_' + inc);
            $(this).find('.selectnumcols').attr('id', 'selectnumcolsrow_' + inc);
            $(this).find('input').attr('class', 'removecustomrow_' + inc);
            $(this).find('.selectcollayout').attr('id', 'selectcollayoutrow_' + inc++);
        });
        customlayout_change_layout(pieformname);

        if (parseInt($('#' + pieformname + '_customlayoutnumrows').val(), 10) < get_max_custom_rows()) {
            $('#addrow').prop('disabled', false);
        }
    };

    CustomLayoutManager.customlayout_change_numcolumns = function(pieformname, columnoptions) {
        var currentrow = $(columnoptions).attr('id').substr($(columnoptions).attr('id').lastIndexOf('_') + 1);
        var numcols = parseInt(columnoptions.options[columnoptions.selectedIndex].value, 10);
        // reverse in order to select the first option
        $.each($('#selectcollayoutrow_' + currentrow + ' > option').get().reverse(), function() {
            if (this.text.split('-').length != numcols) {
                $(this).prop('disabled', true);
                $(this).prop('selected', false);
            }
            else {
                $(this).prop('disabled', false);
                $(this).prop('selected', true);
            }
        });
        customlayout_change_layout(pieformname);
    };

    CustomLayoutManager.customlayout_change_column_layout = function(pieformname) {
        customlayout_change_layout(pieformname);
    };

    CustomLayoutManager.customlayout_submit_layout = function(pieformname) {
        var numrows = parseInt($('#' + pieformname + '_customlayoutnumrows').val(), 10);
        var collayouts = '';
        for (i=0; i<numrows; i++) {
            collayouts += '_row' + [i+1] + '_' + $('#selectcollayoutrow_' + (i+1)).val();
        }

        if (typeof formchangemanager !== 'undefined') {
            formchangemanager.setFormState($('#' + pieformname), FORM_CHANGED);
        }

        var pd   = {
             'id': $('#' + pieformname + '_id').val(),
             'change': 1
             }
        pd['action_addcustomlayout_numrows_' + numrows + collayouts] = 1;
        sendjsonrequest(config['wwwroot'] + 'view/blocks.json.php', pd, 'POST', function(data) {

            var layoutid = data.data.layoutid;

            if (data.data.newlayout) {
                // insert new layout
                // clone and tweak
                var clone = $('.advancedlayoutselect input[type=radio]:first').parent().parent().clone();
                var id = '' + pieformname + '_advancedlayoutselect' + unique_timestamp();
                $('label', clone).attr('for', id).text(data.data.text);
                $('input', clone).attr('id', id).val(layoutid);
                $('svg', clone).replaceWith(data.data.layoutpreview);

                //insert into appropriate row
                var rowcontainer = $('#' + pieformname + '_advancedlayoutselect_row'+numrows);
                if (rowcontainer.length) {
                    $(rowcontainer).append(clone);
                }
                else {
                    // make a row for it
                    var rowtitlediv = $('<h3>').attr('class', 'title');
                    rowtitlediv.html('<strong>' + get_string('nrrows', 'view', numrows) + '</strong>');
                    var rowcontainer = $('<div>').attr({
                        'id': '' + pieformname + '_advancedlayoutselect_row' + numrows,
                        'class': 'layoutoptions-container'
                    });
                    var hr = $('<hr>').attr('class', 'cb');
                    $(rowcontainer).append(clone);
                    $('#' + pieformname + '_advancedlayoutselect_container').append(rowtitlediv);
                    $('#' + pieformname + '_advancedlayoutselect_container').append(rowcontainer);
                    $('#' + pieformname + '_advancedlayoutselect_container').append(hr);


                }
            }

            $('#' + pieformname + '_advancedlayoutselect_container').collapse('show');

            // select and highlight layout
            var radio = $('.advancedlayoutselect :radio[value=' + layoutid +']');
            $(radio).attr("checked","checked");
            $('#' + pieformname + '_currentlayoutselect').val(layoutid);
            highlight_layout($(radio).parent());
            link_thumbs_to_radio_buttons();

            $(radio).trigger("focus");

        });
    };

    // Private Methods
    ////////////////////

    function unique_timestamp() {
          var time = new Date().getTime();
          while (time == new Date().getTime());
          return new Date().getTime();
    }

    function highlight_layout (element) {
        $(element).css('background', '#555');
        $(element).animate({backgroundColor:'#EEE'}, 3000);
    }

    function customlayout_change_layout(pieformname) {
        var numrows = parseInt($('#' + pieformname + '_customlayoutnumrows').val(), 10);
        var collayouts = '';
        for (i=0; i<numrows; i++) {
            collayouts += '_row' + [i+1] + '_' + $('#selectcollayoutrow_' + (i+1)).val();
        }

        var pd   = {
             'id': $('#' + pieformname + '_id').val(),
             'change': 1
             }
        pd['action_updatecustomlayoutpreview_numrows_' + numrows + collayouts] = 1;
         sendjsonrequest(config['wwwroot'] + 'view/blocks.json.php', pd, 'POST', function(data) {
            $('#custompreview').html(data.data);
         });

        if (typeof formchangemanager !== 'undefined') {
            formchangemanager.setFormState($('#' + pieformname), FORM_CHANGED);
        }
    }

}( window.CustomLayoutManager = window.CustomLayoutManager || {}, jQuery ));

function init(pieformname) {
    $('#' + pieformname + '_basic_container legend a, ' +
      '#' + pieformname + '_layout_container legend a, ' +
      '#' + pieformname + '_skin_container legend a'
    ).on("click", function(event) {

        var layoutselected = $('#' + pieformname + '_currentlayoutselect').val();
        var layoutfallback = $('#' + pieformname + '_layoutfallback').val();
        if ($('.advancedlayoutselect :radio[value=' + layoutselected +']').length ) {
            $('.advancedlayoutselect :radio[value=' + layoutselected +']').attr("checked","checked");
        }
        else {
            $('.advancedlayoutselect :radio[value=' + layoutfallback + ']').attr("checked","checked");
            $('#' + pieformname + '_currentlayoutselect').val(layoutfallback);
        }
    });

    $("input[name='layoutselect']").on("change", function(event) {
        $('#' + pieformname + '_currentlayoutselect').val($(this).val());
    });

    $("input[name='advancedlayoutselect']").on("change", function(event) {
        $('#' + pieformname + '_currentlayoutselect').val($(this).val());
    });

    link_thumbs_to_radio_buttons(pieformname);
}

function link_thumbs_to_radio_buttons(pieformname) {
    $('.layoutoption > .thumbnail').each(function(event) {
        $(this).on("click", function(e) {
            $(this).find(':radio').prop('checked', true);
            $('#' + pieformname + '_currentlayoutselect').val( $(this).find(':radio').val() );
        });
    });
}
