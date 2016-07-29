
{if $templatefile == 'homepage' || $filename == 'contact' && !$loggedin || $templatefile == 'vps' || $templatefile == 'pricing' || $templatefile == 'features' || $filename == "cart"}
	<footer class="space2x">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-3">
					<a class="navbar-brand" href="#">{$companyname}</a>
					<p>&copy; {$date_year} {$companyname}. {$LANG.allrightsreserved}</p>
				</div>
				<div class="col-xs-4 col-sm-2">
					<h4 class="title-head">{$LANG.footabout}</h4>
					<ul class="list-unstyled">
						<li><a href="#">Company</a></li>
						<li><a href="#">Blog</a></li>
						<li><a href="#">Affileates</a></li>
						<li><a href="#">Press</a></li>
						<li><a href="#">Terms</a></li>
					</ul>
				</div>
				<div class="col-xs-4 col-sm-2">
					<h4 class="title-head">{$LANG.footproduct}</h4>
					<ul class="list-unstyled">
						<li><a href="#">Features</a></li>
						<li><a href="#">How it Works</a></li>
						<li><a href="#">Pricing</a></li>
						<li><a href="#">Learn</a></li>
						<li><a href="#">Privavy</a></li>
					</ul>
				</div>
				<div class="col-xs-4 col-sm-2">
					<h4 class="title-head">{$LANG.footsupport}</h4>
					<ul class="list-unstyled">
						<li><a href="#">Documintation</a></li>
						<li><a href="#">Delevopers API</a></li>
						<li><a href="#">Learn</a></li>
						<li><a href="#">FAQ</a></li>
						<li><a href="#">Status</a></li>
					</ul>
				</div>
				<div class="col-sm-2 hidden-xs hidden-sm">
					<h4 class="title-head">{$LANG.footconnect}</h4>
					<ul class="list-unstyled">
						<li><a href="#">Facebook</a></li>
						<li><a href="#">Twitter</a></li>
					</ul>
				</div>
				<div class="col-sm-2 hidden-xs hidden-sm">
					{if $languagechangeenabled && count($locales) > 1}
			            <a href="javascript:;" id="languageChooser" class="language" data-toggle="popover">{$LANG.chooselanguage} <span class="caret"></span></a>
			            <div id="languageChooserContent" class="hidden">
			                <ul>
			                    {foreach from=$locales item=locale}
			                        <li><a href="{$currentpagelinkback}language={$locale.language}">{$locale.localisedName}</a></li>
			                    {/foreach}
			                </ul>
			            </div>
			        {/if}
				</div>
			</div>
		</div>
	</footer>
{/if}
