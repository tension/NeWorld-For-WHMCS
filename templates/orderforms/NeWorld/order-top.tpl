
	<section class="order-top">
		<div class="container">
			<ul class="row">
				<li class="col-xs-6 col-sm-3 {if $filename eq "cart" and $smarty.get.a eq ""}active{/if}">
					<a href="{$WEB_ROOT}/cart.php">
						<img src="{$WEB_ROOT}/templates/orderforms/{$carttpl}/img/review.svg" class="theme-gray size-md">
						{$LANG.chooseproduct}
			        </a>
				</li>
				<li class="col-xs-6 col-sm-3 {if $filename eq "cart" and $smarty.get.a eq "view"}active{/if}">
					<a href="{$WEB_ROOT}/cart.php?a=view">
						<img src="{$WEB_ROOT}/templates/orderforms/{$carttpl}/img/choose.svg" class="theme-gray size-md">
				        {$LANG.cartreviewcheckout}
				    </a>
				</li>
				<li class="col-xs-6 col-sm-3 {if $filename eq "cart" and $smarty.get.a eq "checkout"}active{/if}">
					<a href="{$WEB_ROOT}/cart.php?a=checkout">
						<img src="{$WEB_ROOT}/templates/orderforms/{$carttpl}/img/checkout.svg" class="theme-gray size-md">
						{$LANG.orderForm.checkout}
					</a>
				</li>
				<li class="col-xs-6 col-sm-3 {if $filename eq "cart" and $smarty.get.a eq "complete"}active{/if}">
					<a href="{$WEB_ROOT}/cart.php?a=checkout">
						<img src="{$WEB_ROOT}/templates/orderforms/{$carttpl}/img/confirm.svg" class="theme-gray size-md">
						{$LANG.orderconfirmation}
					</a>
				</li>
			</ul>
		</div>
	</section>