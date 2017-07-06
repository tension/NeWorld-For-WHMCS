if (typeof localTrans === 'undefined') {
    localTrans = function (phraseId, fallback)
    {
        if (typeof _localLang !== 'undefined') {
            if (typeof _localLang[phraseId] !== 'undefined') {
                if (_localLang[phraseId].length > 0) {
                    return _localLang[phraseId];
                }
            }
        }

        return fallback;
    }
}

jQuery(document).ready(function(){

    jQuery('#order-standard_cart').find('input').iCheck({
        inheritID: true,
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%'
    });

    if (jQuery('#inputCardNumber').length) {
        jQuery('#inputCardNumber').payment('formatCardNumber');
        jQuery('#inputCardCVV').payment('formatCardCVC');
        jQuery('#inputCardStart').payment('formatCardExpiry');
        jQuery('#inputCardExpiry').payment('formatCardExpiry');
    }

    var $orderSummaryEl = jQuery("#orderSummary");
    if ($orderSummaryEl.length) {
        var offset = jQuery("#scrollingPanelContainer").parent('.row').offset();
        var maxTopOffset = jQuery("#scrollingPanelContainer").parent('.row').outerHeight() - 35;
        var topPadding = 15;
        jQuery(window).resize(function() {
            offset = jQuery("#scrollingPanelContainer").parent('.row').offset();
            maxTopOffset = jQuery("#scrollingPanelContainer").parent('.row').outerHeight() - 35;
            repositionScrollingSidebar();
        });
        jQuery(window).scroll(function() {
            repositionScrollingSidebar();
        });
        repositionScrollingSidebar();
    }

    function repositionScrollingSidebar() {
        if (jQuery("#scrollingPanelContainer").css('float') != 'left') {
            $orderSummaryEl.stop().css('margin-top', '0');
            return false;
        }
        var heightOfOrderSummary =  $orderSummaryEl.outerHeight();
        var newTopOffset = jQuery(window).scrollTop() - offset.top + topPadding;
        if (newTopOffset > maxTopOffset - heightOfOrderSummary) {
            newTopOffset = maxTopOffset - heightOfOrderSummary;
        }
        if (jQuery(window).scrollTop() > offset.top) {
            $orderSummaryEl.stop().animate({
                marginTop: newTopOffset
            });
        } else {
            $orderSummaryEl.stop().animate({
                marginTop: 0
            });
        }
    }

    jQuery("#btnCompleteProductConfig").click(function() {
        var btnOriginalText = jQuery(this).html();
        jQuery(this).find('i').removeClass('fa-arrow-circle-right').addClass('fa-spinner fa-spin');
        jQuery.post("cart.php", 'ajax=1&a=confproduct&' + jQuery("#frmConfigureProduct").serialize(),
            function(data) {
                if (data) {
                    jQuery("#btnCompleteProductConfig").html(btnOriginalText);
                    jQuery("#containerProductValidationErrorsList").html(data);
                    jQuery("#containerProductValidationErrors").removeClass('hidden').show();
                    // scroll to error container if below it
                    if (jQuery(window).scrollTop() > jQuery("#containerProductValidationErrors").offset().top) {
                        jQuery('html, body').scrollTop(jQuery("#containerProductValidationErrors").offset().top - 15);
                    }
                } else {
                    window.location = 'cart.php?a=confdomains';
                }
            }
        );
    });

    jQuery("#productConfigurableOptions").on('ifChecked', 'input', function() {
        recalctotals();
    });
    jQuery("#productConfigurableOptions").on('ifUnchecked', 'input', function() {
        recalctotals();
    });
    jQuery("#productConfigurableOptions").on('change', 'select', function() {
        recalctotals();
    });

    jQuery(".addon-products").on('click', '.panel-addon', function(e) {
        e.preventDefault();
        var $activeAddon = jQuery(this);
        if ($activeAddon.hasClass('panel-addon-selected')) {
            $activeAddon.find('input[type="checkbox"]').iCheck('uncheck');
        } else {
            $activeAddon.find('input[type="checkbox"]').iCheck('check');
        }
    });
    jQuery(".addon-products").on('ifChecked', '.panel-addon input', function(event) {
        var $activeAddon = jQuery(this).parents('.panel-addon');
        $activeAddon.addClass('panel-addon-selected');
        $activeAddon.find('input[type="checkbox"]').iCheck('check');
        $activeAddon.find('.panel-add').html('<i class="fa fa-shopping-cart"></i> '+localTrans('addedToCartRemove', 'Added to Cart (Remove)'));
        recalctotals();
    });
    jQuery(".addon-products").on('ifUnchecked', '.panel-addon input', function(event) {
        var $activeAddon = jQuery(this).parents('.panel-addon');
        $activeAddon.removeClass('panel-addon-selected');
        $activeAddon.find('input[type="checkbox"]').iCheck('uncheck');
        $activeAddon.find('.panel-add').html('<i class="fa fa-plus"></i> '+localTrans('addToCart', 'Add to Cart'));
        recalctotals();
    });

    jQuery(".domain-selection-options input:first").iCheck('check');
    jQuery(".domain-selection-options input:first").parents('.option').addClass('option-selected');
    jQuery("#domain" + jQuery(".domain-selection-options input:first").val()).show();
    jQuery(".domain-selection-options input").on('ifChecked', function(event){
        jQuery(".domain-selection-options .option").removeClass('option-selected');
        jQuery(this).parents('.option').addClass('option-selected');
        jQuery(".domain-input-group").hide();
        jQuery("#domain" + jQuery(this).val()).show();
    });

    jQuery(".domain-selection-options .option").click(function(e) {
        jQuery(this).find('input').iCheck('check');
    });

    jQuery('#frmProductDomain button[type="submit"]').click(function(e) {
        e.preventDefault();
        var btnSearchObj = jQuery(this);
        var preSearchText = btnSearchObj.html();
        jQuery(this).html('<i class="fa fa-spinner fa-spin"></i> ' + preSearchText);
        jQuery("#domainSearchResults").hide();
        jQuery("#domainLoadingSpinner").show();
        var domainoption = jQuery(".domain-selection-options input:checked").val();
        var sld = jQuery("#"+domainoption+"sld").val();
        var tld = '';
        if (domainoption=='incart') {
            var sld = jQuery("#"+domainoption+"sld option:selected").text();
        } else if (domainoption=='subdomain') {
            var tld = jQuery("#"+domainoption+"tld option:selected").text();
        } else {
            var tld = jQuery("#"+domainoption+"tld").val();
        }
        jQuery.post("cart.php", { ajax: 1, a: "domainoptions", sld: sld, tld: tld, checktype: domainoption },
            function(data) {
                jQuery("#domainLoadingSpinner").hide();
                jQuery("#domainSearchResults").html(data);
                jQuery("#domainSearchResults").slideDown();
                btnSearchObj.html(preSearchText);
            }
        );
    });

    jQuery("#btnAlreadyRegistered").click(function() {
        jQuery("#containerNewUserSignup").slideUp('', function() {
            jQuery("#containerExistingUserSignin").hide().removeClass('hidden').slideDown('', function() {
                jQuery("#inputCustType").val('existing');
                jQuery("#btnAlreadyRegistered").fadeOut('', function() {
                    jQuery("#btnNewUserSignup").removeClass('hidden').fadeIn();
                });
            });
        });
        jQuery("#containerNewUserSecurity").hide();
        if (jQuery("#stateselect").attr('required')) {
            jQuery("#stateselect").removeAttr('required').addClass('requiredAttributeRemoved');
        }
    });

    jQuery("#btnNewUserSignup").click(function() {
        jQuery("#containerExistingUserSignin").slideUp('', function() {
            jQuery("#containerNewUserSignup").hide().removeClass('hidden').slideDown('', function() {
                jQuery("#inputCustType").val('new');
                jQuery("#containerNewUserSecurity").show();
                jQuery("#btnNewUserSignup").fadeOut('', function() {
                    jQuery("#btnAlreadyRegistered").removeClass('hidden').fadeIn();
                });
            });
        });
        if (jQuery("#stateselect").hasClass('requiredAttributeRemoved')) {
            jQuery("#stateselect").attr('required', 'required').removeClass('requiredAttributeRemoved');
        }
    });

    jQuery(".payment-methods").on('ifChecked', function(event) {
        if (jQuery(this).hasClass('is-credit-card')) {
            if (!jQuery("#creditCardInputFields").is(":visible")) {
                jQuery("#creditCardInputFields").hide().removeClass('hidden').slideDown();
            }
        } else {
            jQuery("#creditCardInputFields").slideUp();
        }
    });

    jQuery("input[name='ccinfo']").on('ifChecked', function(event) {
        if (jQuery(this).val() == 'new') {
            jQuery("#existingCardInfo").slideUp('', function() {
                jQuery("#newCardInfo").hide().removeClass('hidden').slideDown();
            });
        } else {
            jQuery("#newCardInfo").slideUp('', function() {
                jQuery("#existingCardInfo").hide().removeClass('hidden').slideDown();
            });
        }
    });

    jQuery("#inputDomainContact").on('change', function() {
        if (this.value == "addingnew") {
            jQuery("#domainRegistrantInputFields").hide().removeClass('hidden').slideDown();
        } else {
            jQuery("#domainRegistrantInputFields").slideUp();
        }
    });

    jQuery("#inputNewPassword1").keyup(function () {
        passwordStrength = getPasswordStrength(jQuery(this).val());
        if (passwordStrength >= 75) {
            textLabel = langPasswordStrong;
            cssClass = 'success';
        } else if (passwordStrength >= 30) {
            textLabel = langPasswordModerate;
            cssClass = 'warning';
        } else {
            textLabel = langPasswordWeak;
            cssClass = 'danger';
        }
        jQuery("#passwordStrengthTextLabel").html(langPasswordStrength + ': ' + passwordStrength + '% ' + textLabel);
        jQuery("#passwordStrengthMeterBar").css('width', passwordStrength + '%').attr('aria-valuenow', passwordStrength);
        jQuery("#passwordStrengthMeterBar").removeClass('progress-bar-success progress-bar-warning progress-bar-danger').addClass('progress-bar-' + cssClass);
    });

    jQuery("#btnCheckAvailability").click(function(e) {
        e.preventDefault();
        var buttonContent = jQuery(this).html();
        jQuery(this).html('<i class="fa fa-spinner fa-spin"></i> ' + buttonContent);
        jQuery("#domainSearchResults").hide();
        jQuery("#domainLoadingSpinner").show();
        jQuery.post("cart.php", jQuery("#frmDomainSearch").serialize(),
                function(data) {
                    jQuery("#domainLoadingSpinner").hide();
                    jQuery("#domainSearchResults").html(data).show();
                    jQuery("#btnCheckAvailability").html(buttonContent);
                }
            );
    });

    jQuery("#btnEmptyCart").click(function() {
        jQuery('#modalEmptyCart').modal('show');
    });

    jQuery("#cardType li a").click(function (e) {
        e.preventDefault();
        jQuery("#selectedCardType").html(jQuery(this).html());
        jQuery("#cctype").val(jQuery('span.type', this).html());
    });

});

function domainGotoNextStep() {
    jQuery("#domainLoadingSpinner").show();
    jQuery("#frmProductDomainSelections").submit();
}

function removeItem(type, num) {
    jQuery('#inputRemoveItemType').val(type);
    jQuery('#inputRemoveItemRef').val(num);
    jQuery('#modalRemoveItem').modal('show');
}

function updateConfigurableOptions(i, billingCycle) {

    jQuery.post("cart.php", 'a=cyclechange&ajax=1&i='+i+'&billingcycle='+billingCycle,
        function(data) {
            jQuery("#productConfigurableOptions").html(jQuery(data).find('#productConfigurableOptions').html());
            jQuery('input').iCheck({
                inheritID: true,
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%'
            });
        }
    );
    recalctotals();

}

function recalctotals() {
    if (!jQuery("#orderSummaryLoader").is(":visible")) {
        jQuery("#orderSummaryLoader").fadeIn('fast');
    }

    thisRequestId = Math.floor((Math.random() * 1000000) + 1);
    window.lastSliderUpdateRequestId = thisRequestId;

    var post = jQuery.post("cart.php", 'ajax=1&a=confproduct&calctotal=true&'+jQuery("#frmConfigureProduct").serialize());
    post.done(
        function(data) {
            if (thisRequestId == window.lastSliderUpdateRequestId) {
                jQuery("#producttotal").html(data);
            }
        }
    );
    post.always(
        function() {
            jQuery("#orderSummaryLoader").delay(500).fadeOut('slow');
        }
    );
}

function selectDomainPricing(domainName, price, period, yearsString, suggestionNumber) {
    jQuery("#domainSuggestion" + suggestionNumber).iCheck('check');
    jQuery("[name='domainsregperiod[" + domainName + "]']").val(period);
    jQuery("[name='" + domainName + "-selected-price']").html('<b class="glyphicon glyphicon-shopping-cart"></b>'
        + ' ' + period + ' ' + yearsString + ' @ ' + price);
}

function catchEnter(e) {
    if (e) {
        addtocart();
        e.returnValue=false;
    }
}
