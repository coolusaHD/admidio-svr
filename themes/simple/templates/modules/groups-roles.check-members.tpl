<div class="admidio-content">
    <div class="alert alert-info">
        <p><strong>{$l10n->get('SYS_ROLE')}: {$roleName}</strong></p>
        <p>{$l10n->get('SYS_AGE_CONSTRAINT')}: {$ageConstraint}</p>
    </div>

    {if $violatingMembersCount > 0}
        <div class="alert alert-warning">
            <i class="bi bi-exclamation-triangle-fill"></i>
            {$l10n->get('SYS_MEMBERS_NOT_MEETING_CONSTRAINT', $violatingMembersCount)}
        </div>

        <div class="table-responsive">
            <table class="table table-condensed table-hover">
                <thead>
                    <tr>
                        <th>{$l10n->get('SYS_NAME')}</th>
                        <th>{$l10n->get('SYS_BIRTHDAY')}</th>
                        <th>{$l10n->get('SYS_AGE')}</th>
                        <th>{$l10n->get('SYS_ACTIONS')}</th>
                    </tr>
                </thead>
                <tbody>
                    {foreach $members as $member}
                        <tr>
                            <td>
                                <a href="{$member.profileUrl}" target="_blank">
                                    {$member.name}
                                </a>
                            </td>
                            <td>{$member.birthday}</td>
                            <td>{$member.age}</td>
                            <td>
                                <a href="{$member.profileUrl}" class="admidio-icon-link" target="_blank">
                                    <i class="bi bi-person-circle"></i>
                                    {$l10n->get('SYS_PROFILE')}
                                </a>
                            </td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>
    {else}
        <div class="alert alert-success">
            <i class="bi bi-check-circle-fill"></i>
            {$l10n->get('SYS_ALL_MEMBERS_MEET_CONSTRAINT')}
        </div>
    {/if}
</div>
