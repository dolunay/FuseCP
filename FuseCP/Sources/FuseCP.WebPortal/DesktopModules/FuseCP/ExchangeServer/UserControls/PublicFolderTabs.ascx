<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PublicFolderTabs.ascx.cs" Inherits="FuseCP.Portal.ExchangeServer.UserControls.PublicFolderTabs" %>
<div class="fcp-modern-tabs" role="navigation" aria-label="Public folder sections">
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
