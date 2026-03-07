<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SpaceQuotasControl.ascx.cs" Inherits="FuseCP.Portal.SpaceQuotasControl" %>
<%@ Register Src="UserControls/QuotaViewer.ascx" TagName="QuotaViewer" TagPrefix="uc1" %>

<asp:Repeater ID="dlGroups" runat="server" EnableViewState="false">
    <ItemTemplate>
        <div class="card border-info">
            <div class="card-header">
                <asp:Panel ID="GroupPanel" runat="server" visible='<%# IsGroupVisible((int)Eval("GroupID")) %>'>
                    <strong><%# GetSharedLocalizedString("ResourceGroup." + (string)Eval("GroupName")) %></strong>
                </asp:Panel>
            </div>
            <div class="card-body">
                <asp:Repeater ID="dlQuotas" runat="server" DataSource='<%# GetGroupQuotas((int)Eval("GroupID")) %>' EnableViewState="false">
                    <ItemTemplate>
                        <div class="row">
                            <div class="col-6 text-end">
                                <%# GetQuotaTitle((string)Eval("QuotaName"), (object)Eval("QuotaDescription"))%>:
                            </div>
                            <div class="col-6">
                                <uc1:QuotaViewer ID="quota" runat="server" QuotaTypeId='<%# Eval("QuotaTypeId") %>' QuotaUsedValue='<%# Eval("QuotaUsedValue") %>' QuotaValue='<%# Eval("QuotaValue") %>' QuotaAvailable='<%# Eval("QuotaAvailable") %>'/>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
