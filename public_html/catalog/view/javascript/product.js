/*
 ======================================================================================
 ==  Product         : jQuery Spinner Control
 ==  Company         : MindzGroup Technologies
 ==  Developer       : Anant Anand Gupta
 ==  Version         : 1.0.2
 ==  Date            : 9 May 2011
 ==  Description     : Convert a text input in to a Spinner Control.
 ==  Required Files  : jquery.spinnercontrol.css
 ==  Modified        : for ant-snab.ru by wsLapshin  http://vk.com/wslapshin
 ==  @TASK           : refactor
 ======================================================================================
 */
(function ($) {
    $.fn.SpinnerControl = function (options) {
        this.factValue = null;

        var methods = {
            destroy: function () {
                var $inputControl = this,
                        container = $inputControl.parents('.SpinnerControl').parent();

                container.html('');
            },
            init: function (options) {

                function convertFactToVisual(opt, factValue) {
                    var tD = opt.typedata,
                        koef = 1;
                    if (tD.visualInterval === tD.factInterval) {
                        return +factValue;
                    } else if (tD.visualInterval < tD.factInterval ) { //прибавляемая через кнопки + - единица измерения СОДЕРЖИТ кратные упаковки
                        koef = tD.factInterval/tD.visualInterval;
                        return +(factValue / koef).toFixed(tD.decimalplaces);
                    } else if (tD.factInterval < tD.visualInterval ) { //прибавляемая через кнопки + - единица измерения СОДЕРЖИТСЯ В кратной упаковке
                        koef = tD.visualInterval / tD.factInterval;
                        return +(factValue * koef).toFixed(tD.decimalplaces);
                    } else {
                        console.warn("cant convert fact value " + factValue + " to visual value, because one of intervals either factInterval or visualInterval should be equal to 1");
                        return 0;
                    }
                };

                function convertVisualToFact(opt, visualValue) {
                    var tD = opt.typedata,
                        koef = 1;
                    if (tD.visualInterval === tD.factInterval) {
                        return visualValue;
                    } else if (tD.visualInterval < tD.factInterval) { //прибавляемая через кнопки + - единица измерения СОДЕРЖИТ кратные упаковки
                        koef = tD.factInterval/tD.visualInterval;
                        return +(visualValue * koef).toFixed(tD.decimalplaces);
                    } else if (tD.factInterval < tD.visualInterval) { //прибавляемая через кнопки + - единица измерения СОДЕРЖИТСЯ В кратной упаковке
                        koef = tD.visualInterval / tD.factInterval; 
                        return +(visualValue / koef).toFixed(tD.decimalplaces);
                    } else {
                        console.warn("cant convert visual value " + visualValue + " to visual value, because one of intervals either factInterval or visualInterval should be equal to 1");
                        return 0;
                    }
                }

                // set default options
                var opt = $.extend({
                    type: 'range',
                    typedata: '',
                    //defaultVal: 0,
                    width: '30px',
                    backColor: '#fff',
                    looping: false
                }, options);

                opt.defaultVal = 0;

                var otypedata
                dataVisualInterval = this.attr('data-visualInterval'),
                dataFactInterval = this.attr('data-factInterval'),
                dataStartFactVal = +this.val(),
                dataSpinName = this.attr('data-name');

                if (options != null && options.typedata != null) {
                    otypedata = $.extend({
                        /*min: 0,
                         max: 1E6,*/
                        visualInterval: +dataVisualInterval,
                        factInterval: +dataFactInterval,
                        spinname: dataSpinName,
                        startFactVal: dataStartFactVal,
                        decimalplaces: 0
                    }, options.typedata);
                } else {
                    otypedata = $.extend({
                        /*min: 0,
                         max: 1E6,*/
                        visualInterval: +dataVisualInterval,
                        factInterval: +dataFactInterval,
                        spinname: dataSpinName,
                        startFactVal: dataStartFactVal,
                        decimalplaces: 0
                    });
                }
                otypedata.min = 0;
                otypedata.max = 1E6;
                opt.typedata = otypedata;

                var inputControl = this;

                // validate if the object is a input of text type.
                if (!inputControl.is(':text'))
                    return inputControl;

                if (inputControl.hasClass('jQuerySpinnerControl')) {
                    return inputControl;
                } else {
                    inputControl.addClass('jQuerySpinnerControl');
                }

                // create the Spinner Control body.
                var strContainerDiv = '';
                strContainerDiv += '<div class="SpinnerControl">';
                strContainerDiv += '<div class="LeftButton"></div>';
                strContainerDiv += '<div class="ValueDisplay"></div>';
                strContainerDiv += '<div class="RightButton"></div>';
                strContainerDiv += '</div>';
                strContainerDiv += '<div class="SpinnerName">' + opt.typedata.spinname + '</div>';

                // add the above created control to page
                var objContainerDiv = $(strContainerDiv).insertAfter(inputControl);

                // hide the input control and place within the Spinner Control body
                inputControl.insertAfter($("div.ValueDisplay", objContainerDiv));
                inputControl.css('display', 'none');

                ($("div.ValueDisplay", objContainerDiv)).css({'background-color': opt.backColor});
                ($("div.ValueDisplay", objContainerDiv)).css({'min-width': opt.width});

                switch (opt.type) {
                    case 'range':
                        if (opt.typedata.startFactVal !== 0) {
                            factValue = opt.typedata.startFactVal;
                            opt.defaultVal = convertFactToVisual(opt, opt.typedata.startFactVal);
                        } else {
                            opt.defaultVal = 0;
                            factValue = 0;
                        }

                        // set default value;
                        if (opt.defaultVal < opt.typedata.min || opt.defaultVal > opt.typedata.max) {
                            opt.defaultVal = opt.typedata.min;
                        }
                        if (opt.defaultVal % opt.typedata.visualInterval > 0) {
                            opt.defaultVal = parseInt((opt.defaultVal / opt.typedata.visualInterval).toFixed(0)) * opt.typedata.visualInterval;
                        }

                        inputControl.val(opt.defaultVal.toFixed(opt.typedata.decimalplaces));
                        ($("div.ValueDisplay", objContainerDiv)).html(opt.defaultVal.toFixed(opt.typedata.decimalplaces));

                        var selectedValue = opt.defaultVal,
                            self = this;

                        if ((opt.typedata.max - opt.typedata.min) > opt.typedata.visualInterval) {
                            // attach events;
                            $("div.RightButton", objContainerDiv).click(function () {
                                if ((selectedValue + opt.typedata.visualInterval) <= opt.typedata.max || opt.looping) {
                                    if ((selectedValue + opt.typedata.visualInterval) > opt.typedata.max) {
                                        selectedValue = opt.typedata.min - opt.typedata.visualInterval;
                                    }

                                    var valueData = (selectedValue + opt.typedata.visualInterval).toFixed(opt.typedata.decimalplaces);
                                    selectedValue += opt.typedata.visualInterval;
                                    factValue += opt.typedata.factInterval;


                                    ($("div.ValueDisplay", objContainerDiv)).html(valueData);
                                    inputControl.val(valueData);
                                    self.trigger('spinnerPlus');
                                }
                                return false;
                            });

                            $("div.LeftButton", objContainerDiv).click(function () {
                                if ((selectedValue - opt.typedata.visualInterval) >= opt.typedata.min || opt.looping) {
                                    if ((selectedValue - opt.typedata.visualInterval) < opt.typedata.min) {
                                        selectedValue = opt.typedata.max + opt.typedata.visualInterval;
                                    }
                                    var valueData = (selectedValue - opt.typedata.visualInterval).toFixed(opt.typedata.decimalplaces);
                                    selectedValue -= opt.typedata.visualInterval;
                                    factValue -= opt.typedata.factInterval;


                                    ($("div.ValueDisplay", objContainerDiv)).html(valueData);
                                    inputControl.val(valueData);
                                    self.trigger('spinnerMinus'); 
                                }
                                return false;
                            });
                        }

                        break;
                    case 'list':
                        if (!opt.typedata.list || opt.typedata.list.lenght == 0) {
                            return inputControl;
                        }

                        var listItems = opt.typedata.list.split(',');

                        var selectedIndex = jQuery.inArray(opt.defaultVal, listItems);
                        if (!selectedIndex >= 0) {
                            selectedIndex = 0;
                            opt.defaultVal = listItems[0];
                        }

                        inputControl.val(opt.defaultVal);
                        ($("div.ValueDisplay", objContainerDiv)).html(opt.defaultVal);

                        if (listItems.length > 1) {
                            // attach events;
                            $("div.RightButton", objContainerDiv).click(function () {
                                if (selectedIndex < (listItems.length - 1) || opt.looping) {
                                    if (selectedIndex == listItems.length - 1) {
                                        selectedIndex = -1;
                                    }
                                    selectedIndex++;
                                    var valueData = listItems[selectedIndex];
                                    ($("div.ValueDisplay", objContainerDiv)).html(valueData);
                                    inputControl.val(valueData);
                                }
                                return false;
                            });

                            $("div.LeftButton", objContainerDiv).click(function () {
                                if (selectedIndex > 0 || opt.looping) {
                                    if (selectedIndex == 0) {
                                        selectedIndex = listItems.length;
                                    }
                                    selectedIndex--;
                                    var valueData = listItems[selectedIndex];
                                    ($("div.ValueDisplay", objContainerDiv)).html(valueData);
                                    inputControl.val(valueData);
                                }
                                return false;
                            });
                        }

                        break;
                }
                ;

                // return the selected input control for the chainability
                return inputControl;
            },
            
            /**Получить текущее количество в еденицах кратной упаковки*/ 
            getFactValue: function () {
                return factValue;
            }
        };

        if (methods[options]) {
            return methods[ options ].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof options === 'object' || !options) {
            // Default to "init"
            return methods.init.apply(this, arguments);
        } else {
            $.error('Method ' + options + ' does not exist on jQuery.SpinnerControl');
        }

    };


})(jQuery);

$('a', '.price-for').on('click', function (e) {
    e.preventDefault();

    $('a', '.price-for').removeClass('active');

    var $wholesalePriceEl = $('#wholesalePrice'),
            $priceEl = $('#price'),
            $priceDescrEl = $('#priceDescr'),
            $priceWholesaleDescrEl = $('#priceWholesaleDescr'),
            currencySym = $('#currencySymb').val(),
            unitName = $(this).attr('data-unit'),
            unit = window._antSnabMeta.priceMeta[unitName];

    //fill price values
    $priceEl.html(unit.price_str);
    $wholesalePriceEl.html(unit.price_wholesale_str);

    //fill price descriptions
    var priceDescription = unit.name,
            priceWholesaleDescription = priceDescription;
    if (null !== unit.calcKoef && null !== unit.calcRelString) {
        priceWholesaleDescription += ', ' + unit.calcKoef + ' ' + unit.calcRelString;
    }
    $priceDescrEl.html(priceDescription);
    $priceWholesaleDescrEl.html(priceWholesaleDescription);

    //fill quantity spinner
    var $container = $('.spinner').parents('.OutputContainer'),
            newControl = document.createElement('INPUT'),
            $newControl = $(newControl),
            factVal = $('.spinner').SpinnerControl('getFactValue');

    $newControl.addClass('spinner');
    $($newControl).attr('data-factinterval', unit.salePackageStep);
    $($newControl).attr('data-visualinterval', unit.visualStep);
    $($newControl).attr('data-name', unit.name_plural);
    $($newControl).attr('type', 'text');


    $('.spinner').SpinnerControl('destroy');
    $container.append($newControl);
    $($newControl).SpinnerControl({typedata: {startFactVal: factVal}});

    $(this).addClass('active');
});
