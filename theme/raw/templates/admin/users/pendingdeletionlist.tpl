{if $data}
<table id="pendinglist" class="fullwidth table">
        <thead>
                <th>{str tag=pendingdeletion section=admin}</th>
                <th>{str tag=deletionreason section=admin}</th>
                <th>&nbsp;</th>
        </thead>
        <tbody>
{foreach from=$data item=deletion}
            <tr class="{cycle values='r0,r1'}">
                    <td class="pendinginfo">
                            <div id="pendinginfo_{$deletion->id}">
                                <h3 class="title"><a href="{$deletion->displayurl}">{$deletion->displayname}</a></h3>
                                <div class="detail">{$deletion->username}</div>
                            </div>
                    </td>
                    <td class="pendinginfo">
                            <div class="detail">{$deletion->reason}</div>
                    </td>
                    <td class="">
                        <div class="btn-group">
                            <a class="btn btn-default btn-xs" href="{$WWWROOT}admin/users/actiondeletion.php?d={$deletion->id}&action=approve">
                                <span class="icon icon-lg left icon-check text-success" role="presentation" aria-hidden="true"></span>
                                <span class="btn-approve">{str tag=approve section=admin}</span>
                            </a>
                            <a class="btn btn-default btn-xs" href="{$WWWROOT}admin/users/actiondeletion.php?d={$deletion->id}&action=deny">
                                <span class="icon icon-lg left icon-ban text-danger" role="presentation" aria-hidden="true"></span>
                                <span class="btn-deny">{str tag=deny section=admin}</span></a>
                        </div>
                    </td>
            </tr>
{/foreach}
{else}
    <tr><td><div class="no-results">{str tag=nopendingdeletions section=admin}</div></td></tr>
{/if}
        </tbody>
</table>
