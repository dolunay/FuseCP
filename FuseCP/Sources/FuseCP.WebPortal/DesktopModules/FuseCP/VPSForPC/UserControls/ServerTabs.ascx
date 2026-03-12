<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServerTabs.ascx.cs"
    Inherits="FuseCP.Portal.VPSForPC.UserControls.ServerTabs" %>
<%@ Register Src="../../UserControls/Gauge.ascx" TagName="Gauge" TagPrefix="fcp" %>
<%@ Register Src="../../UserControls/SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>

<asp:Timer runat="server" Interval="3000" ID="refreshTimer" />
<asp:UpdatePanel ID="TabsPanel" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="refreshTimer" EventName="Tick" />
    </Triggers>
    <ContentTemplate>
    
        <table id="TaskTable" runat="server" visible="false">
            <tr>
                <td>
                    <asp:Literal ID="litTaskName" runat="server"></asp:Literal>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>
                    <asp:Localize ID="locStarted" runat="server" Text="Started:" meta:resourcekey="locStarted"></asp:Localize>
                    <asp:Literal ID="litStarted" runat="server"></asp:Literal>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Localize ID="locElapsed" runat="server" Text="Elapsed:" meta:resourcekey="locElapsed"></asp:Localize>
                    <asp:Literal ID="litElapsed" runat="server"></asp:Literal>
                </td>
            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>
                <td>
                    <asp:Repeater ID="repRecords" runat="server" 
                        onitemdatabound="repRecords_ItemDataBound">
                        <ItemTemplate>
                            <div class="fcp-p-2">
                                <asp:Literal ID="litRecord" runat="server"></asp:Literal>
                                <fcp:Gauge id="gauge" runat="server" OneColour="true" />
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </td>
            </tr>
        </table>

        <table class="table table-borderless align-middle mb-0 w-100" id="TabsTable" runat="server" visible="false">
            <tr>
                <td class="Tabs">
                    <div class="fcp-modern-tabs" role="navigation" aria-label="VPS server sections">
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
                </td>
            </tr>
        </table>
        <br />
        
        <fcp:SimpleMessageBox id="messageBox" runat="server" />

    </ContentTemplate>
</asp:UpdatePanel>
