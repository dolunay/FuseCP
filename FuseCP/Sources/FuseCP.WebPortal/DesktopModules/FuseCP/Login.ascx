<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Login.ascx.cs" Inherits="FuseCP.Portal.Login" %>

<div class="card-body mb-3" runat="server" id="userPwdDiv">
    <div class="row">
        <div class="col-sm-12">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person"></i></span>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="usernameValidator" runat="server" CssClass="form-control" ErrorMessage="*" ControlToValidate="txtUsername"></asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <%--<asp:RequiredFieldValidator ID="passwordValidator" runat="server" CssClass="NormalBold" ErrorMessage="*" ControlToValidate="txtPassword"></asp:RequiredFieldValidator>--%>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-6" style="padding-bottom: 15px;">
            <asp:CheckBox ID="chkRemember" runat="server" meta:resourcekey="chkRemember" Text="Remember me on this computer"></asp:CheckBox>
        </div>
        <div class="col-sm-6">
            <asp:LinkButton ID="btnLogin" runat="server" CssClass="btn btn-success float-end" OnClick="btnLogin_Click">
                <asp:Localize runat="server" meta:resourcekey="btnLogin" />&nbsp;<i class="bi bi-box-arrow-in-right" aria-hidden="true"></i></asp:LinkButton>
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col-sm-12">
            <h5><asp:Localize ID="forgotpass" runat="server" meta:resourcekey="forgotpass" /></h5>
            <p><asp:Localize ID="noworries" runat="server" meta:resourcekey="noworries" />
                <asp:LinkButton ID="cmdForgotPassword" runat="server" CssClass="color-green" CausesValidation="False" OnClick="cmdForgotPassword_Click"><asp:Localize runat="server" meta:resourcekey="cmdForgotPassword" /></asp:LinkButton>
                <asp:Localize ID="toresetyourpassword" runat="server" meta:resourcekey="toresetyourpassword" />.</p>
        </div>
    </div>
</div>
<div class="card-body mb-3" runat="server" id="tokenDiv" visible="false">
    <div class="row">
        <div class="col-sm-12"  style="padding-bottom: 15px;">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock"></i></span>
                <asp:TextBox ID="txtPin" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
     <div class="row">
         <div class="col-sm-12">
            <asp:LinkButton ID="StyleButton2" runat="server" CssClass="btn btn-success float-end" OnClick="btnVerifyPin_Click">
                <asp:Localize runat="server" meta:resourcekey="btnLogin" />&nbsp;<i class="bi bi-box-arrow-in-right" aria-hidden="true"></i>
            </asp:LinkButton>
            <asp:LinkButton runat="server" id="btnResendPin" CssClass="btn btn-success" OnClick="btnResendPin_Click">
                <asp:Localize runat="server" meta:resourcekey="btResendPin" />
            </asp:LinkButton>
        </div>
    </div>
</div>
<div class="card-footer">
    <div class="row">
        <div class="col-6">
            <asp:Label ID="lblLanguage" runat="server" meta:resourcekey="lblLanguage" Text="Preferred Language:"></asp:Label>
            <asp:DropDownList ID="ddlLanguage" runat="server" Width="100%" AutoPostBack="True" OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged"></asp:DropDownList>
        </div>
        <div class="col-6">
            <asp:Label ID="lblTheme" runat="server" meta:resourcekey="lblTheme" Text="Theme:"></asp:Label>
            <asp:DropDownList ID="ddlTheme" runat="server" Width="100%" DataValueField="LTRName" DataTextField="DisplayName" AutoPostBack="True" OnSelectedIndexChanged="ddlTheme_SelectedIndexChanged"></asp:DropDownList>
        </div>
    </div>
</div>
