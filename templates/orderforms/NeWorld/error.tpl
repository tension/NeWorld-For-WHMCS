{include file="orderforms/standard_cart/common.tpl"}

<div id="order-standard_cart">

    <div class="row">

        <div class="pull-md-right col-md-9">

            <div class="header-lined">
                <h1>
                    {$LANG.thereisaproblem}
                </h1>
            </div>

        </div>

        <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">

            {include file="orderforms/standard_cart/sidebar-categories.tpl"}

        </div>

        <div class="col-md-9 pull-md-right">

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
