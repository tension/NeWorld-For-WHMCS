
{include file="orderforms/$carttpl/order-top.tpl"}
	
<section class="order-home space2x">
	<div class="container">
		
	{include file="orderforms/$carttpl/common.tpl"}

		<div id="order-standard_cart">
			
			<div class="choosecat">
			    <ul class="row list-unstyled">
			        {foreach key=num item=productgroup from=$productgroups}
			            <li class="col-xs-6 col-sm-3 {if $smarty.get.gid eq "{$productgroup.gid}"}active{/if}">
			            	<a href="cart.php?gid={$productgroup.gid}">{$productgroup.name}</a>
			            </li>
			        {/foreach}
			        {if $loggedin}
			            <li class="col-xs-6 col-sm-3"><a href="cart.php?a=addons">{$LANG.cartproductaddons}</a></li>
				        {if $registerdomainenabled || $transferdomainenabled}
				            {if $renewalsenabled}
				                <li class="col-xs-3"><a href="cart.php?a=renewals">{$LANG.domainrenewals}</a></li>
				            {/if}
				        {/if}
			        {/if}
			        {if $registerdomainenabled}
			            <li class="col-xs-6 col-sm-3">
			            	<a href="cart.php?a=add&domain=register">{$LANG.registerdomain}</a>
			            </li>
			        {/if}
			        {if $registerdomainenabled || $transferdomainenabled}
			            <li class="col-xs-6 col-sm-3">
			            	<a href="cart.php?a=add&domain=transfer">{$LANG.transferdomain}</a>
			            </li>
			        {/if}
			    </ul>
			</div>
			
            <div class="header-lined text-center">
                <h2 class="title-head">
                    {if $productGroup.headline}
                        {$productGroup.headline}
                    {else}
                        {$productGroup.name}
                    {/if}
                </h2>
                {if $productGroup.tagline}
                    <p>{$productGroup.tagline}</p>
                {/if}
            </div>
            
            {if $errormessage}
                <div class="alert alert-danger">
                    {$errormessage}
                </div>
            {/if}
		
            {include file="orderforms/{$carttpl}/sidebar-categories-collapsed.tpl"}

            <div class="products" id="products">
                <div class="row row-eq-height">
                    {foreach $products as $product}
                        <div class="col-md-6">
                            <div class="product clearfix" id="product{$product@iteration}">
                                <header>
                                    <span id="product{$product@iteration}-name">{$product.name}</span>
                                    {if $product.qty}
                                        <span class="qty">
                                            {$product.qty} {$LANG.orderavailable}
                                        </span>
                                    {/if}
                                </header>
                                <div class="product-desc">
                                    {if $product.featuresdesc}
                                        <p id="product{$product@iteration}-description">
                                            {$product.featuresdesc}
                                        </p>
                                    {/if}
                                    <ul>
                                        {foreach $product.features as $feature => $value}
                                            <li id="product{$product@iteration}-feature{$value@iteration}">
                                                <span class="feature-value">{$value}</span>
                                                {$feature}
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                                <footer>
                                    <div class="product-pricing" id="product{$product@iteration}-price">
                                        {if $product.bid}
                                            {$LANG.bundledeal}<br />
                                            {if $product.displayprice}
                                                <span class="price">{$product.displayprice}</span>
                                            {/if}
                                        {else}
                                            {if $product.pricing.hasconfigoptions}
                                                {$LANG.startingfrom}
                                                <br />
                                            {/if}
                                            <span class="price">{$product.pricing.minprice.price}</span>
                                            <br />
                                            {if $product.pricing.minprice.cycle eq "monthly"}
                                                {$LANG.orderpaymenttermmonthly}
                                            {elseif $product.pricing.minprice.cycle eq "quarterly"}
                                                {$LANG.orderpaymenttermquarterly}
                                            {elseif $product.pricing.minprice.cycle eq "semiannually"}
                                                {$LANG.orderpaymenttermsemiannually}
                                            {elseif $product.pricing.minprice.cycle eq "annually"}
                                                {$LANG.orderpaymenttermannually}
                                            {elseif $product.pricing.minprice.cycle eq "biennially"}
                                                {$LANG.orderpaymenttermbiennially}
                                            {elseif $product.pricing.minprice.cycle eq "triennially"}
                                                {$LANG.orderpaymenttermtriennially}
                                            {/if}
                                        {/if}
                                    </div>
                                    <a href="cart.php?a=add&{if $product.bid}bid={$product.bid}{else}pid={$product.pid}{/if}" class="btn btn-success btn-sm" id="product{$product@iteration}-order-button">
                                        <i class="fa fa-shopping-cart"></i>
                                        {$LANG.ordernowbutton}
                                    </a>
                                </footer>
                            </div>
                        </div>
                        {if $product@iteration % 2 == 0}
                            </div>
                            <div class="row row-eq-height">
                        {/if}
                    {/foreach}
                </div>
            </div>
		</div>
	</div>
</section>