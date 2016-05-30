{if $sent}
    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.contactsent textcenter=true}
{/if}

{if $errormessage}
    {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{/if}

{if !$sent}
<div class="row">
	<div class="col-sm-8 col-sm-offset-2">
	    <form method="post" action="contact.php" class="form" role="form">
	        <input type="hidden" name="action" value="send" />
        	<div class="row">
	            <div class="form-group col-md-6">
	                <label for="inputName" class="control-label">{$LANG.supportticketsclientname}</label>
	                <input type="text" name="name" value="{$name}" class="form-control" id="inputName" placeholder="{$LANG.supportticketsclientname}" />
	            </div>
	            
	            <div class="form-group col-md-6">
	                <label for="inputEmail" class="control-label">{$LANG.supportticketsclientemail}</label>
	                <input type="email" name="email" value="{$email}" class="form-control" id="inputEmail" placeholder="{$LANG.supportticketsclientemail}" />
	            </div>
        	</div>
			
            <div class="form-group">
                <label for="inputSubject" class="control-label">{$LANG.supportticketsticketsubject}</label>
                <input type="subject" name="subject" value="{$subject}" class="form-control" id="inputSubject" />
            </div>
            <div class="form-group">
                <label for="inputMessage" class="control-label">{$LANG.contactmessage}</label>
                <textarea name="message" rows="7" class="form-control" id="inputMessage">{$message}</textarea>
            </div>
            
            {include file="$template/includes/captcha.tpl"}

            <div class="form-group">
                <div class="text-center">
                    <button type="submit" class="btn btn-primary" style="min-width: 100px;">{$LANG.contactsend}</button>
                </div>
            </div>
	    </form>
	</div>
</div>
{/if}
