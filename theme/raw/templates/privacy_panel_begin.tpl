{if $institutionprivacy}
<div id="instprivacy" class="inst js-hidden panel panel-default">
{elseif $institutionterms}
<div id ="insttermsandconditions" class ="inst js-hidden panel panel-default">
{else}
<div class="panel panel-default">
{/if}
    <div class="last form-group collapsible-group">
        <fieldset class="pieform-fieldset last collapsible">
            <legend>
                <h4>

                    <a
                    {if $institutionprivacy}
                        href="#dropdowninstprivacy"
                    {elseif $institutionterms}
                        href="#dropdowninstterms"
                    {else}
                        href="#dropdown{$privacy->id}"
                    {/if}
                    data-toggle="collapse" aria-expanded="false" aria-controls="dropdown" class="collapsed">
                        {$privacytitle}
                        <span class="icon icon-chevron-down collapse-indicator right pull-right"></span>
                    </a>
                </h4>
            </legend>
            <div class="fieldset-body collapse {if (!($privacy->agreed && $ignoreagreevalue) || $ignoreformswitch)}in{/if}"
              {if $institutionprivacy}
                  id="dropdowninstprivacy">
              {elseif $institutionterms}
                  id="dropdowninstterms">
              {else}
                  id="dropdown{$privacy->id}">
              {/if}
                {if $privacytime}
                    <span class="text-midtone pull-right">{str tag='lastupdated' section='admin'} {$privacytime} </span>
                {/if}
                {if $institutionprivacy}
                    <div id ="instprivacytext" class="insttext"></div>
                {elseif $institutionterms}
                    <div id ="insttermsandconditionstext" class="insttext"></div>
                {else}
                    <div class="last-updated-offset">
                        {$privacy->content|safe}
                    </div>
                {/if}
