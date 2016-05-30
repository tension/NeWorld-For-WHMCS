{include file="orderforms/$carttpl/common.tpl"}
	
<section class="order-home space2x">
	<div class="container">
		
		<div id="order-standard_cart">
		
		    <div class="row">
		
		        <div class="col-md-12">
		
		            <div class="header-lined">
		                <h1>{$LANG.cartdomainsconfig}</h1>
		            </div>
		
		        </div>
		
		        <div class="col-md-12">
		
		            {include file="orderforms/$carttpl/sidebar-categories-collapsed.tpl"}
		
		            <form method="post" action="{$smarty.server.PHP_SELF}?a=confdomains" id="frmConfigureDomains">
		                <input type="hidden" name="update" value="true" />
		
		                <p>{$LANG.orderForm.reviewDomainAndAddons}</p>
		
		                {if $errormessage}
		                    <div class="alert alert-danger" role="alert">
		                        <p>{$LANG.orderForm.correctErrors}:</p>
		                        <ul>
		                            {$errormessage}
		                        </ul>
		                    </div>
		                {/if}
		
		                {foreach $domains as $num => $domain}
		
		                    <div class="sub-heading">
		                        <span>{$domain.domain}</span>
		                    </div>
		
		                    <div class="row">
		                        <div class="col-sm-6">
		                            <div class="form-group">
		                                <label>{$LANG.orderregperiod}</label>
		                                <br />
		                                {$domain.regperiod} {$LANG.orderyears}
		                            </div>
		                        </div>
		                        <div class="col-sm-6">
		                            <div class="form-group">
		                                <label>{$LANG.hosting}</label>
		                                <br />
		                                {if $domain.hosting}<span style="color:#009900;">[{$LANG.cartdomainshashosting}]</span>{else}<a href="cart.php" style="color:#cc0000;">[{$LANG.cartdomainsnohosting}]</a>{/if}
		                            </div>
		                        </div>
		                        {if $domain.eppenabled}
		                            <div class="col-sm-12">
		                                <div class="form-group prepend-icon">
		                                    <input type="text" name="epp[{$num}]" id="inputEppcode{$num}" value="{$domain.eppvalue}" class="field" placeholder="{$LANG.domaineppcode}" />
		                                    <label for="cardno" class="field-icon">
		                                        <i class="fa fa-calendar"></i>
		                                    </label>
		                                    <span class="field-help-text">
		                                        {$LANG.domaineppcodedesc}
		                                    </span>
		                                </div>
		                            </div>
		                        {/if}
		                    </div>
		
		                    {if $domain.dnsmanagement || $domain.emailforwarding || $domain.idprotection}
		                        <div class="row addon-products">
		
		                            {if $domain.dnsmanagement}
		                                <div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount}">
		                                    <div class="panel panel-default panel-addon{if $domain.dnsmanagementselected} panel-addon-selected{/if}">
		                                        <div class="panel-body">
		                                            <label>
		                                                <input type="checkbox" name="dnsmanagement[{$num}]"{if $domain.dnsmanagementselected} checked{/if} />
		                                                {$LANG.domaindnsmanagement}
		                                            </label><br />
		                                            {$LANG.domainaddonsdnsmanagementinfo}
		                                        </div>
		                                        <div class="panel-price">
		                                            {$domain.dnsmanagementprice} / {$domain.regperiod} {$LANG.orderyears}
		                                        </div>
		                                        <div class="panel-add">
		                                            <i class="fa fa-plus"></i>
		                                            {$LANG.orderForm.addToCart}
		                                        </div>
		                                    </div>
		                                </div>
		                            {/if}
		
		                            {if $domain.idprotection}
		                                <div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount}">
		                                    <div class="panel panel-default panel-addon{if $domain.idprotectionselected} panel-addon-selected{/if}">
		                                        <div class="panel-body">
		                                            <label>
		                                                <input type="checkbox" name="idprotection[{$num}]"{if $domain.idprotectionselected} checked{/if} />
		                                                {$LANG.domainidprotection}
		                                                </label><br />
		                                            {$LANG.domainaddonsidprotectioninfo}
		                                        </div>
		                                        <div class="panel-price">
		                                            {$domain.idprotectionprice} / {$domain.regperiod} {$LANG.orderyears}
		                                        </div>
		                                        <div class="panel-add">
		                                            <i class="fa fa-plus"></i>
		                                            {$LANG.orderForm.addToCart}
		                                        </div>
		                                    </div>
		                                </div>
		                            {/if}
		
		                            {if $domain.emailforwarding}
		                                <div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount}">
		                                    <div class="panel panel-default panel-addon{if $domain.emailforwardingselected} panel-addon-selected{/if}">
		                                        <div class="panel-body">
		                                            <label>
		                                                <input type="checkbox" name="emailforwarding[{$num}]"{if $domain.emailforwardingselected} checked{/if} />
		                                                {$LANG.domainemailforwarding}
		                                            </label><br />
		                                            {$LANG.domainaddonsemailforwardinginfo}
		                                        </div>
		                                        <div class="panel-price">
		                                            {$domain.emailforwardingprice} / {$domain.regperiod} {$LANG.orderyears}
		                                        </div>
		                                        <div class="panel-add">
		                                            <i class="fa fa-plus"></i>
		                                            {$LANG.orderForm.addToCart}
		                                        </div>
		                                    </div>
		                                </div>
		                            {/if}
		
		                        </div>
		                    {/if}
		                    {foreach from=$domain.fields key=domainfieldname item=domainfield}
		                        <div class="row">
		                            <div class="col-sm-4">{$domainfieldname}:</div>
		                            <div class="col-sm-8">{$domainfield}</div>
		                        </div>
		                    {/foreach}
		
		                {/foreach}
		
		                {if $atleastonenohosting}
		
		                    <div class="sub-heading">
		                        <span>{$LANG.domainnameservers}</span>
		                    </div>
		
		                    <p>{$LANG.cartnameserversdesc}</p>
		
		                    <div class="row">
		                        <div class="col-sm-4">
		                            <div class="form-group">
		                                <label for="inputNs1">{$LANG.domainnameserver1}</label>
		                                <input type="text" class="form-control" id="inputNs1" name="domainns1" value="{$domainns1}" />
		                            </div>
		                        </div>
		                        <div class="col-sm-4">
		                            <div class="form-group">
		                                <label for="inputNs2">{$LANG.domainnameserver2}</label>
		                                <input type="text" class="form-control" id="inputNs2" name="domainns2" value="{$domainns2}" />
		                            </div>
		                        </div>
		                        <div class="col-sm-4">
		                            <div class="form-group">
		                                <label for="inputNs3">{$LANG.domainnameserver3}</label>
		                                <input type="text" class="form-control" id="inputNs3" name="domainns3" value="{$domainns3}" />
		                            </div>
		                        </div>
		                        <div class="col-sm-4">
		                            <div class="form-group">
		                                <label for="inputNs1">{$LANG.domainnameserver4}</label>
		                                <input type="text" class="form-control" id="inputNs4" name="domainns4" value="{$domainns4}" />
		                            </div>
		                        </div>
		                        <div class="col-sm-4">
		                            <div class="form-group">
		                                <label for="inputNs5">{$LANG.domainnameserver5}</label>
		                                <input type="text" class="form-control" id="inputNs5" name="domainns5" value="{$domainns5}" />
		                            </div>
		                        </div>
		                    </div>
		
		                {/if}
		
		                <div class="text-center">
		                    <button type="submit" class="btn btn-primary btn-lg">
		                        {$LANG.continue}
		                        &nbsp;<i class="fa fa-arrow-circle-right"></i>
		                    </button>
		                </div>
		
		            </form>
		        </div>
		    </div>
		</div>
	</div>
</section>
