{include file="orderforms/$carttpl/common.tpl"}
	
<section class="order-home space2x">
	<div class="container">
		
		<div id="order-standard_cart">
		
		    <div class="row">
		
		        <div class="col-md-12">
		
		            <div class="header-lined">
		                <h1>{$LANG.cartproductaddons}</h1>
		            </div>
		
		        </div>
		
		        <div class="col-md-12">
		
		            {include file="orderforms/$carttpl/sidebar-categories-collapsed.tpl"}
		
		            {if count($addons) == 0}
		                <div class="alert alert-warning text-center" role="alert">
		                    {$LANG.cartproductaddonsnone}
		                </div>
		                <p class="text-center">
		                    <a href="clientarea.php" class="btn btn-default">
		                        <i class="fa fa-arrow-circle-left"></i>
		                        {$LANG.orderForm.returnToClientArea}
		                    </a>
		                </p>
		            {/if}
		
		            <div class="products">
		                <div class="row row-eq-height">
		                    {foreach $addons as $num => $addon}
		                        <div class="col-md-6">
		                            <div class="product clearfix" id="product{$num}">
		                                <form method="post" action="{$smarty.server.PHP_SELF}?a=add" class="form-inline">
		                                    <input type="hidden" name="aid" value="{$addon.id}" />
			                                <h4 class="text-center">
			                                    <span>{$addon.name}</span>
			                                    {if $product.qty}
			                                        <span class="qty">
			                                            {$product.qty} {$LANG.orderavailable}
			                                        </span>
			                                    {/if}
			                                </h4>
		                                    <div class="product-desc" style="padding: 10px">
		                                        <p>{$addon.description}</p>
		                                        <div class="form-group" style="margin: 0 -10px;">
		                                            <select name="productid" id="inputProductId{$num}" class="col-sm-10">
		                                                {foreach $addon.productids as $product}
		                                                    <option value="{$product.id}">
		                                                        {$product.product}{if $product.domain} - {$product.domain}{/if}
		                                                    </option>
		                                                {/foreach}
		                                            </select>
		                                        </div>
		                                    </div>
			                                <div class="product-btm">
			                                    <div class="product-pricing pull-left" id="product{$product.pid}-price">
			               		                    {if $addon.free}
		                                                {$LANG.orderfree}
		                                            {else}
		                                                <span class="price">
		                                                {$addon.recurringamount} {$addon.billingcycle}</span>
		                                                {if $addon.setupfee}<br />+ {$addon.setupfee} {$LANG.ordersetupfee}{/if}
		                                            {/if}
			                                    </div>
			                                    <div class="pull-right">
		                                        <button type="submit" class="btn btn-success btn-sm">
		                                            <i class="fa fa-shopping-cart"></i>
		                                            {$LANG.ordernowbutton}
		                                        </button>
			                                    </div>
			                                </div>
		                                </form>
		                            </div>
		                        </div>
		                        {if $num % 2 != 0}
		                            </div>
		                            <div class="row row-eq-height">
		                        {/if}
		                    {/foreach}
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</section>
