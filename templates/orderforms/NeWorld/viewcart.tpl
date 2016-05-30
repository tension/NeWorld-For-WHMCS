{if $checkout}

    {include file="orderforms/$carttpl/checkout.tpl"}

{else}

    <script>
        // Define state tab index value
        var statesTab = 10;
        var stateNotRequired = true;
    </script>
    {include file="orderforms/$carttpl/common.tpl"}
    <script type="text/javascript" src="{$BASE_PATH_JS}/StatesDropdown.js"></script>
    
    {include file="orderforms/$carttpl/order-top.tpl"}

	<section class="order-home space2x">
		<div class="container">

		    <div id="order-standard_cart">
		
		        <div class="row">
		            <div class="col-md-8">
			            <div class="header-lined">
					        <h1>{$LANG.cartreviewcheckout}</h1>
					    </div>
		
		                {if $promoerrormessage}
		                    <div class="alert alert-warning text-center" role="alert">
		                        {$promoerrormessage}
		                    </div>
		                {elseif $errormessage}
		                    <div class="alert alert-danger" role="alert">
		                        <p>{$LANG.orderForm.correctErrors}:</p>
		                        <ul>
		                            {$errormessage}
		                        </ul>
		                    </div>
		                {elseif $promotioncode && $rawdiscount eq "0.00"}
		                    <div class="alert alert-info text-center" role="alert">
		                        {$LANG.promoappliedbutnodiscount}
		                    </div>
		                {elseif $promoaddedsuccess}
		                    <div class="alert alert-success text-center" role="alert">
		                        {$LANG.orderForm.promotionAccepted}
		                    </div>
		                {/if}
		
		                {if $bundlewarnings}
		                    <div class="alert alert-warning" role="alert">
		                        <strong>{$LANG.bundlereqsnotmet}</strong><br />
		                        <ul>
		                            {foreach from=$bundlewarnings item=warning}
		                                <li>{$warning}</li>
		                            {/foreach}
		                        </ul>
		                    </div>
		                {/if}
		
		                <form method="post" action="cart.php?a=view">
							<div class="check-main" style="margin-bottom: 20px;">
			                    <div class="view-cart-items-header">
			                        <div class="row">
			                            <div class="{if $showqtyoptions}col-sm-5{else}col-sm-7{/if} col-xs-7">
			                                {$LANG.orderForm.productOptions}
			                            </div>
			                            {if $showqtyoptions}
			                                <div class="col-sm-2 hidden-xs text-center">
			                                    {$LANG.orderForm.qty}
			                                </div>
			                            {/if}
			                            <div class="col-sm-4 col-xs-5 text-right">
			                                {$LANG.orderForm.priceCycle}
			                            </div>
			                        </div>
			                    </div>
			                    <div class="view-cart-items">
			
			                        {foreach $products as $num => $product}
			                            <div class="item">
			                                <div class="row">
			                                    <div class="{if $showqtyoptions}col-sm-5{else}col-sm-7{/if}">
			                                        <span class="item-title">
			                                            {$product.productinfo.name}
			                                            <a href="{$smarty.server.PHP_SELF}?a=confproduct&i={$num}" class="btn btn-link btn-xs">
			                                                <i class="fa fa-pencil"></i>
			                                                {$LANG.orderForm.edit}
			                                            </a>
			                                            <span class="visible-xs-inline">
			                                                <button type="button" class="btn btn-link btn-xs btn-remove-from-cart" onclick="removeItem('p','{$num}')">
			                                                    <i class="fa fa-times"></i>
			                                                    {$LANG.orderForm.remove}
			                                                </button>
			                                            </span>
			                                        </span>
			                                        <span class="item-group">
			                                            {$product.productinfo.groupname}
			                                        </span>
			                                        {if $product.domain}
			                                            <span class="item-domain">
			                                                {$product.domain}
			                                            </span>
			                                        {/if}
			                                        {if $product.configoptions}
			                                            <small>
			                                            {foreach key=confnum item=configoption from=$product.configoptions}
			                                                &nbsp;&raquo; {$configoption.name}: {if $configoption.type eq 1 || $configoption.type eq 2}{$configoption.option}{elseif $configoption.type eq 3}{if $configoption.qty}{$configoption.option}{else}{$LANG.no}{/if}{elseif $configoption.type eq 4}{$configoption.qty} x {$configoption.option}{/if}<br />
			                                            {/foreach}
			                                            </small>
			                                        {/if}
			                                    </div>
			                                    {if $showqtyoptions}
			                                        <div class="col-sm-2 item-qty">
			                                            {if $product.allowqty}
			                                                <input type="number" name="qty[{$num}]" value="{$product.qty}" class="form-control text-center" />
			                                                <button type="submit" class="btn btn-xs">
			                                                    {$LANG.orderForm.update}
			                                                </button>
			                                            {/if}
			                                        </div>
			                                    {/if}
			                                    <div class="col-sm-4 item-price">
			                                        <span>{$product.pricing.totalTodayExcludingTaxSetup}</span>
			                                        <span class="cycle">{$product.billingcyclefriendly}</span>
			                                        {if $product.pricing.productonlysetup}
			                                            {$product.pricing.productonlysetup} {$LANG.ordersetupfee}
			                                        {/if}
			                                        {if $product.proratadate}<br />({$LANG.orderprorata} {$product.proratadate}){/if}
			                                    </div>
			                                    <div class="col-sm-1 hidden-xs">
			                                        <button type="button" class="btn btn-link btn-xs btn-remove-from-cart" onclick="removeItem('p','{$num}')">
			                                            <i class="fa fa-times"></i>
			                                        </button>
			                                    </div>
			                                </div>
			                            </div>
			                            {foreach key=addonnum item=addon from=$product.addons}
			                                <div class="item">
			                                    <div class="row">
			                                        <div class="col-sm-7">
			                                            <span class="item-title">
			                                                {$addon.name}
			                                            </span>
			                                            <span class="item-group">
			                                                {$LANG.orderaddon}
			                                            </span>
			                                            {if $addon.setup}
			                                                <span class="item-setup">
			                                                    {$addon.setup} {$LANG.ordersetupfee}
			                                                </span>
			                                            {/if}
			                                        </div>
			                                        <div class="col-sm-4 item-price">
			                                            <span>{$addon.totaltoday}</span>
			                                            <span class="cycle">{$addon.billingcyclefriendly}</span>
			                                        </div>
			                                    </div>
			                                </div>
			                            {/foreach}
			                        {/foreach}
			
			                        {foreach $addons as $num => $addon}
			                            <div class="item">
			                                <div class="row">
			                                    <div class="col-sm-7">
			                                        <span class="item-title">
			                                            {$addon.name}
			                                            <span class="visible-xs-inline">
			                                                <button type="button" class="btn btn-link btn-xs btn-remove-from-cart" onclick="removeItem('a','{$num}')">
			                                                    <i class="fa fa-times"></i>
			                                                    {$LANG.orderForm.remove}
			                                                </button>
			                                            </span>
			                                        </span>
			                                        <span class="item-group">
			                                            {$addon.productname}
			                                        </span>
			                                        {if $addon.domainname}
			                                            <span class="item-domain">
			                                                {$addon.domainname}
			                                            </span>
			                                        {/if}
			                                        {if $addon.setup}
			                                            <span class="item-setup">
			                                                {$addon.setup} {$LANG.ordersetupfee}
			                                            </span>
			                                        {/if}
			                                    </div>
			                                    <div class="col-sm-4 item-price">
			                                        <span>{$addon.pricingtext}</span>
			                                        <span class="cycle">{$addon.billingcyclefriendly}</span>
			                                    </div>
			                                    <div class="col-sm-1 hidden-xs">
			                                        <button type="button" class="btn btn-link btn-xs btn-remove-from-cart" onclick="removeItem('a','{$num}')">
			                                            <i class="fa fa-times"></i>
			                                        </button>
			                                    </div>
			                                </div>
			                            </div>
			                        {/foreach}
			
			                        {foreach $domains as $num => $domain}
			                            <div class="item">
			                                <div class="row">
			                                    <div class="col-sm-7">
			                                        <span class="item-title">
			                                            {if $domain.type eq "register"}{$LANG.orderdomainregistration}{else}{$LANG.orderdomaintransfer}{/if}
			                                            <a href="{$smarty.server.PHP_SELF}?a=confdomains" class="btn btn-link btn-xs">
			                                                <i class="fa fa-pencil"></i>
			                                                Edit
			                                            </a>
			                                            <span class="visible-xs-inline">
			                                                <button type="button" class="btn btn-link btn-xs btn-remove-from-cart" onclick="removeItem('d','{$num}')">
			                                                    <i class="fa fa-times"></i>
			                                                    {$LANG.orderForm.remove}
			                                                </button>
			                                            </span>
			                                        </span>
			                                        {if $domain.domain}
			                                            <span class="item-domain">
			                                                {$domain.domain}
			                                            </span>
			                                        {/if}
			                                        {if $domain.dnsmanagement}&nbsp;&raquo; {$LANG.domaindnsmanagement}<br />{/if}
			                                        {if $domain.emailforwarding}&nbsp;&raquo; {$LANG.domainemailforwarding}<br />{/if}
			                                        {if $domain.idprotection}&nbsp;&raquo; {$LANG.domainidprotection}<br />{/if}
			                                    </div>
			                                    <div class="col-sm-4 item-price">
			                                        <span>{$domain.price}</span>
			                                        <span class="cycle">{$domain.regperiod} {$LANG.orderyears}</span>
			                                    </div>
			                                    <div class="col-sm-1 hidden-xs">
			                                        <button type="button" class="btn btn-link btn-xs btn-remove-from-cart" onclick="removeItem('d','{$num}')">
			                                            <i class="fa fa-times"></i>
			                                        </button>
			                                    </div>
			                                </div>
			                            </div>
			                        {/foreach}
			
			                        {foreach key=num item=domain from=$renewals}
			                            <div class="item">
			                                <div class="row">
			                                    <div class="col-sm-7">
			                                        <span class="item-title">
			                                            {$LANG.domainrenewal}
			                                        </span>
			                                        <span class="item-domain">
			                                            {$domain.domain}
			                                        </span>
			                                        {if $domain.dnsmanagement}&nbsp;&raquo; {$LANG.domaindnsmanagement}<br />{/if}
			                                        {if $domain.emailforwarding}&nbsp;&raquo; {$LANG.domainemailforwarding}<br />{/if}
			                                        {if $domain.idprotection}&nbsp;&raquo; {$LANG.domainidprotection}<br />{/if}
			                                    </div>
			                                    <div class="col-sm-4 item-price">
			                                        <span>{$domain.price}</span>
			                                        <span class="cycle">{$domain.regperiod} {$LANG.orderyears}</span>
			                                    </div>
			                                    <div class="col-sm-1">
			                                        <button type="button" class="btn btn-link btn-xs btn-remove-from-cart" onclick="removeItem('r','{$num}')">
			                                            <i class="fa fa-times"></i>
			                                            <span class="visible-xs">{$LANG.orderForm.remove}</span>
			                                        </button>
			                                    </div>
			                                </div>
			                            </div>
			                        {/foreach}
			
			                        {if $cartitems == 0}
			                            <div class="view-cart-empty">
			                                {$LANG.cartempty}
			                            </div>
			                        {/if}
			
			                    </div>
							</div>
		
		                    {if $cartitems > 0}
		                        <div class="empty-cart">
		                            <button type="button" class="btn btn-link btn-xs" id="btnEmptyCart">
		                                <i class="fa fa-trash"></i>
		                                <span>{$LANG.emptycart}</span>
		                            </button>
		                        </div>
		                    {/if}
		
		                </form>
		
		                {foreach $gatewaysoutput as $gatewayoutput}
		                    <div class="view-cart-gateway-checkout">
		                        {$gatewayoutput}
		                    </div>
		                {/foreach}
		
		                <div class="view-cart-tabs">
		                    <ul class="nav nav-tabs" role="tablist">
		                        <li role="presentation" class="active"><a href="#applyPromo" aria-controls="applyPromo" role="tab" data-toggle="tab">{$LANG.orderForm.applyPromoCode}</a></li>
		                        {if $taxenabled && !$loggedin}
		                            <li role="presentation"><a href="#calcTaxes" aria-controls="calcTaxes" role="tab" data-toggle="tab">{$LANG.orderForm.estimateTaxes}</a></li>
		                        {/if}
		                    </ul>
		                    <div class="tab-content">
		                        <div role="tabpanel" class="tab-pane active promo" id="applyPromo">
		                            {if $promotioncode}
		                                <div class="view-cart-promotion-code">
		                                    {$promotioncode} - {$promotiondescription}
		                                </div>
		                                <div class="text-center">
		                                    <a href="{$smarty.server.PHP_SELF}?a=removepromo" class="btn btn-default btn-sm">
		                                        {$LANG.orderForm.removePromotionCode}
		                                    </a>
		                                </div>
		                            {else}
		                                <form method="post" action="cart.php?a=view">
		                                    <div class="form-group prepend-icon ">
		                                        <label for="cardno" class="field-icon">
		                                            <i class="fa fa-ticket"></i>
		                                        </label>
		                                        <input type="text" name="promocode" id="inputPromotionCode" class="field" placeholder="{lang key="orderPromoCodePlaceholder"}" required="required">
		                                    </div>
		                                    <button type="submit" name="validatepromo" class="btn btn-block" value="{$LANG.orderpromovalidatebutton}">
		                                        {$LANG.orderpromovalidatebutton}
		                                    </button>
		                                </form>
		                            {/if}
		                        </div>
		                        <div role="tabpanel" class="tab-pane" id="calcTaxes">
		
		                            <form method="post" action="cart.php?a=setstateandcountry">
		                                <div class="form-horizontal">
		                                    <div class="form-group">
		                                        <label for="inputState" class="col-sm-4 control-label">{$LANG.orderForm.state}</label>
		                                        <div class="col-sm-7">
		                                            <input type="text" name="state" id="inputState" value="{$clientsdetails.state}" class="form-control"{if $loggedin} disabled="disabled"{/if} />
		                                        </div>
		                                    </div>
		                                    <div class="form-group">
		                                        <label for="inputCountry" class="col-sm-4 control-label">{$LANG.orderForm.country}</label>
		                                        <div class="col-sm-7">
		                                            <select name="country" id="inputCountry" class="form-control">
		                                                {foreach $countries as $countrycode => $countrylabel}
		                                                    <option value="{$countrycode}"{if (!$country && $countrycode == $defaultcountry) || $countrycode eq $country} selected{/if}>
		                                                        {$countrylabel}
		                                                    </option>
		                                                {/foreach}
		                                            </select>
		                                        </div>
		                                    </div>
		                                    <div class="form-group text-center">
		                                        <button type="submit" class="btn">
		                                            {$LANG.orderForm.updateTotals}
		                                        </button>
		                                    </div>
		                                </div>
		                            </form>
		
		                        </div>
		                    </div>
		                </div>
		
		            </div>
		            
		            <div class="col-md-4">
		
		                <div class="order-summary check-side">
			                <div class="header-lined">
								<h1>{$LANG.ordersummary}</h1>
			                </div>
		                    <div class="summary-container">
		
		                        <div class="subtotal">
		                            <span class="pull-left">{$LANG.ordersubtotal}</span>
		                            <span class="pull-right">{$subtotal}</span>
		                        </div>
		                        
		                        {if $promotioncode || $taxrate || $taxrate2}
		                            <div class="bordered-totals">
		                                {if $promotioncode}
		                                    <div class="clearfix">
		                                        <span class="pull-left">{$promotiondescription}</span>
		                                        <span class="pull-right">{$discount}</span>
		                                    </div>
		                                {/if}
		                                {if $taxrate}
		                                    <div class="clearfix">
		                                        <span class="pull-left">{$taxname} @ {$taxrate}%</span>
		                                        <span class="pull-right">{$taxtotal}</span>
		                                    </div>
		                                {/if}
		                                {if $taxrate2}
		                                    <div class="clearfix">
		                                        <span class="pull-left">{$taxname2} @ {$taxrate2}%</span>
		                                        <span class="pull-right">{$taxtotal2}</span>
		                                    </div>
		                                {/if}
		                            </div>
		                        {/if}
		                        {if $totalrecurringmonthly || $totalrecurringquarterly || $totalrecurringsemiannually || $totalrecurringannually || $totalrecurringbiennially || $totalrecurringtriennially}
		                            <div class="recurring-totals clearfix">
		                                <span class="pull-left">{$LANG.orderForm.totals}</span>
		                                <span class="pull-right recurring-charges">
		    {if $totalrecurringmonthly}{$totalrecurringmonthly} {$LANG.orderpaymenttermmonthly}<br />{/if}
		    {if $totalrecurringquarterly}{$totalrecurringquarterly} {$LANG.orderpaymenttermquarterly}<br />{/if}
		    {if $totalrecurringsemiannually}{$totalrecurringsemiannually} {$LANG.orderpaymenttermsemiannually}<br />{/if}
		    {if $totalrecurringannually}{$totalrecurringannually} {$LANG.orderpaymenttermannually}<br />{/if}
		    {if $totalrecurringbiennially}{$totalrecurringbiennially} {$LANG.orderpaymenttermbiennially}<br />{/if}
		    {if $totalrecurringtriennially}{$totalrecurringtriennially} {$LANG.orderpaymenttermtriennially}<br />{/if}
		                                </span>
		                            </div>
		                        {/if}
		
		                        <div class="total">
		                            <strong>{$total}</strong>
		                        </div>
		
		                    </div>
		                </div>
		            </div>
		            <div class="col-sm-12">
				        <div class="text-right check-btm">
					        <a href="javascript:;" onclick="javascript:history.go(-1);" class="btn btn-default btn-check pull-left">
						        <i class="fa fa-angle-double-left" aria-hidden="true"></i> 返回
						    </a>
				            <p class="tos">
				                <a href="cart.php" class="btn btn-link btn-continue-shopping" id="continueShopping">{$LANG.orderForm.continueShopping}</a>
				            </p>
				            			
				            <a href="cart.php?a=checkout" class="btn btn-success btn-check{if $cartitems == 0} disabled{/if}" id="checkout">
				                {$LANG.orderForm.checkout}
				                &nbsp;<i class="fa fa-arrow-circle-right"></i>
				            </a>
				        </div>
					</div>
		        </div>
		
		        <form method="post" action="cart.php">
		            <input type="hidden" name="a" value="remove" />
		            <input type="hidden" name="r" value="" id="inputRemoveItemType" />
		            <input type="hidden" name="i" value="" id="inputRemoveItemRef" />
		            <div class="modal fade modal-remove-item" id="modalRemoveItem" tabindex="-1" role="dialog">
		                <div class="modal-dialog" role="document">
		                    <div class="modal-content">
		                        <div class="modal-header">
		                            <button type="button" class="close" data-dismiss="modal" aria-label="{$LANG.orderForm.close}">
		                                <span aria-hidden="true">&times;</span>
		                            </button>
		                            <h4 class="modal-title">
		                                <i class="fa fa-times fa-3x"></i>
		                                <span>{$LANG.orderForm.removeItem}</span>
		                            </h4>
		                        </div>
		                        <div class="modal-body">
		                            {$LANG.cartremoveitemconfirm}
		                        </div>
		                        <div class="modal-footer">
		                            <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.no}</button>
		                            <button type="submit" class="btn btn-primary">{$LANG.yes}</button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </form>
		
		        <form method="post" action="cart.php">
		            <input type="hidden" name="a" value="empty" />
		            <div class="modal fade modal-remove-item" id="modalEmptyCart" tabindex="-1" role="dialog">
		                <div class="modal-dialog" role="document">
		                    <div class="modal-content">
		                        <div class="modal-header">
		                            <button type="button" class="close" data-dismiss="modal" aria-label="{$LANG.orderForm.close}">
		                                <span aria-hidden="true">&times;</span>
		                            </button>
		                            <h4 class="modal-title">
		                                <i class="fa fa-trash fa-3x"></i>
		                                <span>{$LANG.emptycart}</span>
		                            </h4>
		                        </div>
		                        <div class="modal-body">
		                            {$LANG.cartemptyconfirm}
		                        </div>
		                        <div class="modal-footer">
		                            <button type="button" class="btn btn-default" data-dismiss="modal">{$LANG.no}</button>
		                            <button type="submit" class="btn btn-primary">{$LANG.yes}</button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		        </form>
    		</div>
		</div>
	</section>
{/if}