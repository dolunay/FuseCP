<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginForgotPassword.ascx.cs" Inherits="FuseCP.Portal.LoginForgotPassword" %>
<div class="card-body form-horizontal">
    <div class="mb-3">
	<asp:Label ID="lblUsername" runat="server" meta:resourcekey="lblUsername" Text="User name:" CssClass="col-sm-2"></asp:Label>
	<div class="col-sm-10">
				<asp:TextBox id="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
				<asp:RequiredFieldValidator id="usernameValidator" runat="server" ControlToValidate="txtUsername" ErrorMessage="*"
					CssClass="alert alert-warning"></asp:RequiredFieldValidator></div>
        </div>
    </div>
<div class="card-footer text-end">
	<asp:LinkButton id="btnSend" CssClass="btn btn-success" runat="server" OnClick="btnSend_Click"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnSendtext"/> </asp:LinkButton>
	<asp:LinkButton id="cmdBack" runat="server" CssClass="btn btn-secondary float-start" CausesValidation="False" OnClick="cmdBack_Click"><i class="bi bi-arrow-left" aria-hidden="true"></i>&nbsp;<asp:Localize runat="server" meta:resourcekey="cmdBack" /> </asp:LinkButton>
</div>
