<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RDSCollectionTabs.ascx.cs" Inherits="FuseCP.Portal.RDS.UserControls.RdsServerTabs" %>
<div class="nav nav-tabs pb-2">
            <asp:DataList ID="rdsTabs" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" EnableViewState="false">
                <ItemStyle Wrap="False" />
                <ItemTemplate >
                    <asp:HyperLink ID="lnkTab" runat="server" CssClass="Tab fcp-tab-link-padding" NavigateUrl='<%# Eval("Url") %>' OnClick="return tabClicked();">
                        <%# Eval("Name") %>
                    </asp:HyperLink>
                </ItemTemplate>
                <SelectedItemStyle Wrap="False" />
                <SelectedItemTemplate>
                    <asp:HyperLink ID="lnkSelTab" runat="server" CssClass="ActiveTab fcp-tab-link-padding" NavigateUrl='<%# Eval("Url") %>' OnClick="return tabClicked();">
                        <%# Eval("Name") %>
                    </asp:HyperLink>
                </SelectedItemTemplate>                
            </asp:DataList>
</div>
<script type="text/javascript" src="/DesktopModules/FuseCP/Scripts/tab-progress.js"></script>
