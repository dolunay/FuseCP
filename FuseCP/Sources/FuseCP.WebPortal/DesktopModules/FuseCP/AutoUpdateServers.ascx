<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AutoUpdateServers.ascx.cs" Inherits="FuseCP.Portal.AutoUpdateServers" %>
<%@ Register TagPrefix="fcp" TagName="ProductVersion" Src="SkinControls/ProductVersion.ascx" %>
<%@ Import Namespace="FuseCP.Portal" %>

    <div class="buttons-in-panel-header">
<asp:Label ID="lblSelectVersion" runat="server">Select version</asp:Label>
<asp:DropDownList ID="ddlSelectVersion" runat="server"></asp:DropDownList>
</div>
<div class="card-body">
<asp:DataList ID="dlServers" Runat="server" RepeatLayout="Flow"  RepeatDirection="Horizontal">

	<ItemTemplate>
        <div class="col-md-4">
            <div class="card border-info server-panel matchHeight">
                <div class="card-header">
                    <h3 class="card-title m-0 d-flex align-items-center gap-2" title="<%# PortalAntiXSS.EncodeOld((((string)Eval("ServerName")) ?? string.Empty).Trim()) %>">
                        <i class="bi bi-server" aria-hidden="true"></i>
                        <asp:CheckBox ID="chkServer" AutoPostBack="true" runat="server" Checked="true" Value='<%# Eval("ServerID") %>' />
                        <span><%# PortalAntiXSS.EncodeOld((((string)Eval("ServerName")) ?? string.Empty).Trim()) %></span>
                    </h3>
                </div> 
            </div>
        </div>
    </ItemTemplate>
</asp:DataList>
</div>
<div class="card-footer text-end">
    <div class="float-start">
    <asp:Label ID="lblUpdateMessage" runat="server" CssClass="float-start" Text="This will update all servers to version:" /> <fcp:ProductVersion id="fcpVersion" runat="server" AssemblyName="FuseCP.Portal.Modules"/><br />
	</div>
    <asp:Button ID="btnUpdateServers" runat="server" meta:resourcekey="btnUpdateServers" Text="Update Servers" CssClass="btn btn-success" OnClick="btnUpdateServers_Click" />
</div>

<asp:Panel CssClass="FailedList" ID="failedList" runat="server" Visible="false">
    <table class="failed">
        <asp:Repeater runat="server" ID="lstFailed">
            <HeaderTemplate>
                <thead><tr><th>Server</th><th>Message</th></tr></thead>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# getServerName(((KeyValuePair<int,string>)Container.DataItem).Key) %></td>
                    <td><%# ((KeyValuePair<int,string>)Container.DataItem).Value %></td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
</asp:Panel>

<table id="tblEmptyList" runat="server" class="table table-borderless mb-0 w-100">
    <tr>
        <td class="Normal text-center">
            <asp:Label ID="lblEmptyList" runat="server" meta:resourcekey="lblEmptyList" Text="Empty list..."></asp:Label>
        </td>
    </tr>
</table>
