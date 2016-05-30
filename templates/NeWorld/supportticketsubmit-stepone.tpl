
<div class="ticket space2x text-center">
	<h3>{$LANG.supportticketsheader}</h3>
</div>


<div class="row">
    <div class="col-sm-10 col-sm-offset-1">
        <div class="row">
            {foreach from=$departments key=num item=department}
                <div class="col-md-6 margin-bottom">
	                <div class=" ticket-main">
	                    <h4>
                            <a href="{$smarty.server.PHP_SELF}?step=2&amp;deptid={$department.id}">
                                <i class="fa fa-envelope"></i>
                                &nbsp;{$department.name}
                            </a>
	                    </h4>
	                    {if $department.description}
	                        <p>{$department.description}</p>
	                    {/if}
	                </div>
                </div>
                {if $num % 2 == true}
                    <div class="clearfix"></div>
                {/if}
            {foreachelse}
                {include file="$template/includes/alert.tpl" type="info" msg=$LANG.nosupportdepartments textcenter=true}
            {/foreach}
        </div>
    </div>
</div>
