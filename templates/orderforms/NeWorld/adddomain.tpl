{include file="orderforms/$carttpl/common.tpl"}
	
<section class="order-home space2x">
	<div class="container">
		
		<div id="order-standard_cart">
		
		    <div class="row">
		
		        <div class="12">
		
		            <div class="header-lined">
		                <h1>
		                    {if $domain eq "register"}
		                        {$LANG.registerdomain}
		                    {elseif $domain eq "transfer"}
		                        {$LANG.transferdomain}
		                    {/if}
		                </h1>
		            </div>
		
		        </div>
		
		        <div class="col-md-12">
		
		            {include file="orderforms/$carttpl/sidebar-categories-collapsed.tpl"}
		
		            {if $domain == 'register'}
		                <p>{$LANG.orderForm.findNewDomain}</p>
		            {else}
		                <p>{$LANG.orderForm.transferExistingDomain}</p>
		            {/if}
		
		            <form method="post" action="cart.php" id="frmDomainSearch">
		                <input type="hidden" name="a" value="domainoptions" />
		                <input type="hidden" name="checktype" value="{$domain}" />
		                <input type="hidden" name="ajax" value="1" />
		
		                <div class="row domain-add-domain">
		                    <div class="col-sm-8 col-xs-12 col-sm-offset-1">
		                        <div class="row domains-row">
		                            <div class="col-xs-9">
		                                <div class="input-group">
		                                    <span class="input-group-addon">{lang key='orderForm.www'}</span>
		                                    <input type="text" name="sld" value="{$sld}" id="inputDomain" class="form-control" autocapitalize="none" />
		                                </div>
		                            </div>
		                            <div class="col-xs-3">
		                                <select name="tld" class="form-control">
		                                    {if $domain == 'register'}
		                                        {foreach $registertlds as $listtld}
		                                            <option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>
		                                                {$listtld}
		                                            </option>
		                                        {/foreach}
		                                    {else}
		                                        {foreach $transfertlds as $listtld}
		                                            <option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>
		                                                {$listtld}
		                                            </option>
		                                        {/foreach}
		                                    {/if}
		                                </select>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="col-sm-2 col-xs-12">
		                        <button type="submit" class="btn btn-primary btn-block" id="btnCheckAvailability">
		                            {if $domain eq "register"}
		                                {$LANG.orderForm.check}
		                            {else}
		                                {$LANG.domainstransfer}
		                            {/if}
		                        </button>
		                    </div>
		                </div>
		
		            </form>
		
		            <div class="domain-loading-spinner" id="domainLoadingSpinner">
		                <i class="fa fa-3x fa-spinner fa-spin"></i>
		            </div>
		
		            <form method="post" action="cart.php?a=add&domain={$domain}">
		                <div class="domain-search-results" id="domainSearchResults"></div>
		            </form>
		
		        </div>
		    </div>
		</div>
	</div>
</section>

{*
 * If we have availability results, then the form was submitted w/a domain.
 * Thus we want to do a search and show the results.
 *}
{if $availabilityresults}
    <script>
        jQuery(document).ready(function() {
            jQuery('#btnCheckAvailability').click();
        });
    </script>
{/if}
