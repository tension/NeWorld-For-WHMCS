{include file="orderforms/$carttpl/common.tpl"}
	
<section class="order-home space2x">
	<div class="container">
				
		<div id="order-standard_cart">
		
		    <div class="row">
		
		        <div class="col-md-12">
		
		            <div class="header-lined">
		                <h1>{$LANG.domaincheckerchoosedomain}</h1>
		            </div>
		
		        </div>
		
		        <div class="col-md-12">
		
		            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}
		
		            <form id="frmProductDomain" onsubmit="checkdomain();return false">
		
		                <div class="domain-selection-options">
		                    {if $incartdomains}
		                        <div class="option">
		                            <label>
		                                <input type="radio" name="domainoption" value="incart" id="selincart" />{$LANG.cartproductdomainuseincart}
		                            </label>
		                            <div class="domain-input-group clearfix" id="domainincart">
		                                <div class="row">
		                                    <div class="col-sm-8 col-sm-offset-1 col-md-6 col-md-offset-2">
		                                        <div class="domains-row">
		                                            <select id="incartsld" name="incartdomain" class="form-control">
		                                                {foreach key=num item=incartdomain from=$incartdomains}
		                                                    <option value="{$incartdomain}">{$incartdomain}</option>
		                                                {/foreach}
		                                            </select>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <button type="submit" class="btn btn-primary btn-block">
		                                            {$LANG.orderForm.use}
		                                        </button>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    {/if}
		                    {if $registerdomainenabled}
		                        <div class="option">
		                            <label>
		                                <input type="radio" name="domainoption" value="register" id="selregister" />{$LANG.cartregisterdomainchoice|sprintf2:$companyname}
		                            </label>
		                            <div class="domain-input-group clearfix" id="domainregister">
		                                <div class="row">
		                                    <div class="col-sm-8 col-sm-offset-1">
		                                        <div class="row domains-row">
		                                            <div class="col-xs-9">
		                                                <div class="input-group">
		                                                    <span class="input-group-addon">{$LANG.orderForm.www}</span>
		                                                    <input type="text" id="registersld" value="{$sld}" class="form-control" autocapitalize="none" />
		                                                </div>
		                                            </div>
		                                            <div class="col-xs-3">
		                                                <select id="registertld" class="form-control">
		                                                    {foreach from=$registertlds item=listtld}
		                                                        <option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>{$listtld}</option>
		                                                    {/foreach}
		                                                </select>
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <button type="submit" class="btn btn-primary btn-block">
		                                            {$LANG.orderForm.check}
		                                        </button>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    {/if}
		                    {if $transferdomainenabled}
		                        <div class="option">
		                            <label>
		                                <input type="radio" name="domainoption" value="transfer" id="seltransfer" />{$LANG.carttransferdomainchoice|sprintf2:$companyname}
		                            </label>
		                            <div class="domain-input-group clearfix" id="domaintransfer">
		                                <div class="row">
		                                    <div class="col-sm-8 col-sm-offset-1">
		                                        <div class="row domains-row">
		                                            <div class="col-xs-9">
		                                                <div class="input-group">
		                                                    <span class="input-group-addon">www.</span>
		                                                    <input type="text" id="transfersld" value="{$sld}" class="form-control" autocapitalize="none" />
		                                                </div>
		                                            </div>
		                                            <div class="col-xs-3">
		                                                <select id="transfertld" class="form-control">
		                                                    {foreach from=$transfertlds item=listtld}
		                                                        <option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>{$listtld}</option>
		                                                    {/foreach}
		                                                </select>
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <button type="submit" class="btn btn-primary btn-block">
		                                            {$LANG.orderForm.transfer}
		                                        </button>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    {/if}
		                    {if $owndomainenabled}
		                        <div class="option">
		                            <label>
		                                <input type="radio" name="domainoption" value="owndomain" id="selowndomain" />{$LANG.cartexistingdomainchoice|sprintf2:$companyname}
		                            </label>
		                            <div class="domain-input-group clearfix" id="domainowndomain">
		                                <div class="row">
		                                    <div class="col-sm-9">
		                                        <div class="row domains-row">
		                                            <div class="col-xs-2 text-right">
		                                                <p class="form-control-static">www.</p>
		                                            </div>
		                                            <div class="col-xs-7">
		                                                <input type="text" id="owndomainsld" value="{$sld}" placeholder="{$LANG.yourdomainplaceholder}" class="form-control" autocapitalize="none" />
		                                            </div>
		                                            <div class="col-xs-3">
		                                                <input type="text" id="owndomaintld" value="{$tld|substr:1}" placeholder="{$LANG.yourtldplaceholder}" class="form-control" autocapitalize="none" />
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <button type="submit" class="btn btn-primary btn-block" id="useOwnDomain">
		                                            {$LANG.orderForm.use}
		                                        </button>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    {/if}
		                    {if $subdomains}
		                        <div class="option">
		                            <label>
		                                <input type="radio" name="domainoption" value="subdomain" id="selsubdomain" />{$LANG.cartsubdomainchoice|sprintf2:$companyname}
		                            </label>
		                            <div class="domain-input-group clearfix" id="domainsubdomain">
		                                <div class="row">
		                                    <div class="col-sm-9">
		                                        <div class="row domains-row">
		                                            <div class="col-xs-2 text-right">
		                                                <p class="form-control-static">http://</p>
		                                            </div>
		                                            <div class="col-xs-5">
		                                                <input type="text" id="subdomainsld" value="{$sld}" placeholder="yourname" class="form-control" autocapitalize="none" />
		                                            </div>
		                                            <div class="col-xs-5">
		                                                <select id="subdomaintld" class="form-control">
		                                                    {foreach $subdomains as $subid => $subdomain}
		                                                        <option value="{$subid}">{$subdomain}</option>
		                                                    {/foreach}
		                                                </select>
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div class="col-sm-2">
		                                        <button type="submit" class="btn btn-primary btn-block">
		                                            {$LANG.orderForm.check}
		                                        </button>
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                    {/if}
		                </div>
		
		                {if $freedomaintlds}
		                    <p>* <em>{$LANG.orderfreedomainregistration} {$LANG.orderfreedomainappliesto}: {$freedomaintlds}</em></p>
		                {/if}
		
		            </form>
		
		            <div class="clearfix"></div>
		
		            <div class="domain-loading-spinner" id="domainLoadingSpinner">
		                <i class="fa fa-3x fa-spinner fa-spin"></i>
		            </div>
		
		            <form method="post" action="cart.php?a=add&pid={$pid}&domainselect=1" id="frmProductDomainSelections">
		                <div class="domain-search-results" id="domainSearchResults"></div>
		            </form>
		
		        </div>
		    </div>
		</div>
	</div>
</section>
