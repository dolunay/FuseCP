<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Login.ascx.cs" Inherits="FuseCP.Portal.Login" %>


<div class="card-body mb-3" runat="server" id="userPwdDiv">
    <div class="row g-3 mb-3">
        <div class="col-sm-12">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-person" aria-hidden="true"></i></span>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="usernameValidator" runat="server" ErrorMessage="*" Text="" ControlToValidate="txtUsername" Display="None" ValidationGroup="LoginForm"></asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="row g-3 mb-3">
        <div class="col-sm-12">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock" aria-hidden="true"></i></span>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="passwordValidator" runat="server" ErrorMessage="*" Text="" ControlToValidate="txtPassword" Display="None" ValidationGroup="LoginForm"></asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="row g-2 align-items-center mb-2">
        <div class="col-sm-6 mb-2 mb-sm-0">
            <asp:CheckBox ID="chkRemember" runat="server" meta:resourcekey="chkRemember" Text="Remember me on this computer"></asp:CheckBox>
        </div>
        <div class="col-sm-6 text-sm-end">
            <asp:LinkButton ID="btnLogin" runat="server" CssClass="btn btn-success" OnClick="btnLogin_Click" ValidationGroup="LoginForm" CausesValidation="True">
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
    <div class="row mb-3">
        <div class="col-sm-12">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-lock" aria-hidden="true"></i></span>
                <asp:TextBox ID="txtPin" runat="server" CssClass="form-control"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="pinValidator" runat="server" ErrorMessage="*" Text="" ControlToValidate="txtPin" Display="None" ValidationGroup="PinForm"></asp:RequiredFieldValidator>
        </div>
    </div>
     <div class="row">
         <div class="col-sm-12">
            <div class="d-flex justify-content-end flex-wrap gap-2">
                <asp:LinkButton runat="server" ID="btnResendPin" CssClass="btn btn-success" OnClick="btnResendPin_Click">
                    <asp:Localize runat="server" meta:resourcekey="btResendPin" />
                </asp:LinkButton>
                <asp:LinkButton ID="StyleButton2" runat="server" CssClass="btn btn-success" OnClick="btnVerifyPin_Click" ValidationGroup="PinForm" CausesValidation="True">
                    <asp:Localize runat="server" meta:resourcekey="btnLogin" />&nbsp;<i class="bi bi-box-arrow-in-right" aria-hidden="true"></i>
                </asp:LinkButton>
            </div>
        </div>
    </div>
</div>

<div class="card-footer">
    <div class="row g-3 align-items-end">
        <div class="col-6">
            <asp:Label ID="lblLanguage" runat="server" CssClass="form-label mb-1" meta:resourcekey="lblLanguage" Text="Preferred Language:"></asp:Label>
            <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged"></asp:DropDownList>
        </div>
        <div class="col-6">
            <asp:Label ID="lblTheme" runat="server" CssClass="form-label mb-1" meta:resourcekey="lblTheme" Text="Theme:"></asp:Label>
            <asp:DropDownList ID="ddlTheme" runat="server" CssClass="form-select" DataValueField="LTRName" DataTextField="DisplayName" AutoPostBack="True" OnSelectedIndexChanged="ddlTheme_SelectedIndexChanged"></asp:DropDownList>
        </div>
    </div>
</div>

<script type="text/javascript">
    (function () {
        function byIdSuffix(idSuffix) {
            return document.querySelector('[id$="' + idSuffix + '"]');
        }

        function wireEnterToClick(inputSuffix, buttonSuffix) {
            var input = byIdSuffix(inputSuffix);
            if (!input) return;

            input.addEventListener('keydown', function (event) {
                if (event.key !== 'Enter') return;

                var button = byIdSuffix(buttonSuffix);
                if (!button) return;

                event.preventDefault();
                button.click();
            });
        }

        function init() {
            wireEnterToClick('txtUsername', 'btnLogin');
            wireEnterToClick('txtPassword', 'btnLogin');
            wireEnterToClick('txtPin', 'StyleButton2');
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', init);
        } else {
            init();
        }
    })();
</script>
