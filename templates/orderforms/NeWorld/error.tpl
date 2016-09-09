{include file="orderforms/NeWorld/common.tpl"}

<section class="order-error space2x">
	<div class="container">
		<div id="order-standard_cart">
		
		    <div class="row">
		
		        <div class="col-md-10 col-md-offset-1">
		
		            <div class="header-lined">
		                <h1>
		                    {$LANG.thereisaproblem}
		                </h1>
		            </div>
		
		        </div>
		
		        <div class="col-md-10 col-md-offset-1">
		
		            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}
		
		            <div class="alert alert-danger error-heading">
		                <i class="fa fa-warning"></i>
		                {$errortitle}
		            </div>
		
		            <div class="row">
		                <div class="col-sm-8 col-sm-offset-2">
		
		                    <p class="margin-bottom">{$errormsg}</p>
		
		                    <div class="text-center">
		                        <a href="javascript:history.go(-1)" class="btn btn-default">
		                            <i class="fa fa-arrow-left"></i>&nbsp;
		                            {$LANG.problemgoback}
		                        </a>
		                    </div>
		
		                </div>
		            </div>
		
		        </div>
		    </div>
		</div>
	</div>
</section>
