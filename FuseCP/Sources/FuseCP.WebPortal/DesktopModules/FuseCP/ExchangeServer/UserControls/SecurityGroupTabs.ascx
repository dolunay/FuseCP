<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SecurityGroupTabs.ascx.cs" Inherits="FuseCP.Portal.ExchangeServer.UserControls.SecurityGroupTabs" %>
<div class="fcp-modern-tabs" role="navigation" aria-label="Security group sections">
    <ul class="nav nav-tabs fcp-modern-nav-tabs" role="tablist">
        <asp:Repeater ID="rptTabs" runat="server" EnableViewState="false">
            <ItemTemplate>
                <li class="nav-item" role="presentation">
                    <asp:HyperLink
                        ID="lnkTab"
                        runat="server"
                        CssClass='<%# GetTabCssClass(Container.ItemIndex) %>'
                        NavigateUrl='<%# Eval("Url") %>'
                        role="tab"
                        aria-selected='<%# IsSelectedTab(Container.ItemIndex) ? "true" : "false" %>'>
                        <%# Eval("Name") %>
                    </asp:HyperLink>
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
