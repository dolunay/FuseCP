<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ServersAddServer.ascx.cs"
    Inherits="FuseCP.Portal.ServersAddServer" %>
<%@ Register Src="UserControls/ServerPasswordControl.ascx" TagName="ServerPasswordControl" TagPrefix="uc1" %>
<%@ Register Src="UserControls/EnableAsyncTasksSupport.ascx" TagName="EnableAsyncTasksSupport"
    TagPrefix="fcp" %>
<fcp:EnableAsyncTasksSupport id="asyncTasks" runat="server" />
<asp:Panel ID="ServersAddServerPanel" runat="server" DefaultButton="btnAdd">
    <div class="card-body form-horizontal">
        <div class="mb-3">
            <asp:Label ID="lblServerName" runat="server" CssClass="form-label col-sm-2" meta:resourcekey="lblServerName" style="font-weight:bold"></asp:Label>
            <div class="col-sm-10">
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" Text="New Server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="valServerName" runat="server" ErrorMessage="*" ControlToValidate="txtName"></asp:RequiredFieldValidator>
            </div>
            <asp:Label ID="lblServerUrl" runat="server" CssClass="form-label col-sm-2" meta:resourcekey="lblServerUrl" style="font-weight:bold"></asp:Label>
            <div class="col-sm-10">
                <asp:TextBox ID="txtUrl" runat="server" CssClass="form-control" Text="http://127.0.0.1:9003"></asp:TextBox>
                <asp:RequiredFieldValidator ID="valServerUrl" runat="server" ErrorMessage="*" ControlToValidate="txtUrl"></asp:RequiredFieldValidator>
            </div>
            <asp:Label ID="lblServerPassword" runat="server" CssClass="form-label col-sm-2" meta:resourcekey="lblServerPassword" style="font-weight:bold"></asp:Label>
            <div class="col-sm-10">
                <uc1:ServerPasswordControl id="serverPassword" runat="server"></uc1:ServerPasswordControl>
            </div>
            <div class="col-sm-10 col-md-offset-2">
                <asp:CheckBox runat="server" ID="cbAutoDiscovery" Checked="false" meta:resourcekey="cbAutoDiscovery" />
            </div>
        </div>
    </div>
    <div class="card-footer text-end">
        <asp:LinkButton id="btnCancel" runat="server" CausesValidation="False" CssClass="btn btn-warning" OnClick="btnCancel_Click">
            <i class="bi bi-x-lg">&nbsp;</i>&nbsp;
            <asp:Localize runat="server" meta:resourcekey="btnCancel"/>
        </asp:LinkButton>
        &nbsp;
        <asp:LinkButton id="btnAdd" runat="server" ValidationGroup="Server" CssClass="btn btn-success" OnClick="btnAdd_Click" OnClientClick="ShowProgressDialog('Adding New server...');">
            <i class="bi bi-plus-lg">&nbsp;</i>&nbsp;
            <asp:Localize runat="server" meta:resourcekey="btnAddText"/>
        </asp:LinkButton>
    </div>
</asp:Panel>
