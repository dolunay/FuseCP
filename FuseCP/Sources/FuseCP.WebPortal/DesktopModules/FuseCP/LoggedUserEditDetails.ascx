<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoggedUserEditDetails.ascx.cs" Inherits="FuseCP.Portal.LoggedUserEditDetails" %>
<%@ Register TagPrefix="dnc" TagName="UserContact" Src="UserControls/ContactDetails.ascx" %>
<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="UserControls/CollapsiblePanel.ascx" %>
<%@ Register Src="UserControls/PasswordControl.ascx" TagName="PasswordControl" TagPrefix="uc2" %>
<%@ Register Src="UserControls/EmailControl.ascx" TagName="EmailControl" TagPrefix="uc2" %>
<asp:Panel ID="pnlEdit" runat="server" DefaultButton="btnUpdate">
<div class="card-body form-horizontal fcp-form-sheet">

        <asp:Panel ID="pnlAccount" runat="server" DefaultButton="cmdChangePassword">
            <div class="fcp-form-section">
                <div id="rowUsernameReadonly" runat="server" class="row mb-4 align-items-center">
                    <asp:Label ID="lblUserNameText" runat="server" meta:resourcekey="lblUserNameText" Text="User name:" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                    <div class="col-sm-10">
                        <div class="fcp-readonly-field fcp-readonly-field-hero">
                            <asp:Label ID="lblUsername" Runat="server"></asp:Label>
                        </div>
                    </div>
                </div>
                <uc2:PasswordControl ID="userPassword" runat="server" ValidationGroup="NewPassword" />
                <div id="rowChangePassword" runat="server" class="row mb-4">
                    <div class="col-sm-10 offset-sm-2">
                        <div class="fcp-form-actions">
                            <asp:Button id="cmdChangePassword" runat="server" meta:resourcekey="cmdChangePassword" Text="Change Password" CssClass="btn btn-success" OnClick="cmdChangePassword_Click" ValidationGroup="NewPassword"></asp:Button>
                            <asp:Label ID="lblChangePasswordWarning" runat="server" CssClass="fcp-inline-warning">Warning: This will end the current session.</asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <div class="fcp-form-section">
            <div class="row mb-3">
                <asp:Label ID="lblFirstName" runat="server" meta:resourcekey="lblFirstName" Text="First name:" AssociatedControlID="txtFirstName" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox id="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator id="firstNameValidator" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="txtFirstName"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <asp:Label ID="lblLastName" runat="server" meta:resourcekey="lblLastName" Text="Last name:" AssociatedControlID="txtLastName" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                <div class="col-sm-10">
                    <asp:TextBox id="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator id="lastNameValidator" runat="server" ErrorMessage="*" Display="Dynamic" ControlToValidate="txtLastName"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="row mb-3">
                <asp:Label ID="lblEmail" runat="server" meta:resourcekey="lblEmail" Text="E-mail:" AssociatedControlID="txtEmail" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                <div class="col-sm-10">
                    <uc2:EmailControl id="txtEmail" runat="server"></uc2:EmailControl>
                </div>
            </div>
            <div class="row mb-3">
                <asp:Label ID="lblSecondaryEmail" runat="server" meta:resourcekey="lblSecondaryEmail" Text="Secondary e-mail:" AssociatedControlID="txtSecondaryEmail" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                <div class="col-sm-10">
                    <uc2:EmailControl id="txtSecondaryEmail" runat="server" RequiredEnabled="false"></uc2:EmailControl>
                </div>
            </div>
            <div class="row mb-3">
                <asp:Label ID="lblMailFormat" runat="server" meta:resourcekey="lblMailFormat" Text="Mail Format:" AssociatedControlID="ddlMailFormat" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                <div class="col-sm-10">
                    <asp:DropDownList ID="ddlMailFormat" runat="server" CssClass="form-control" resourcekey="ddlMailFormat">
                        <asp:ListItem Value="Text">PlainText</asp:ListItem>
                        <asp:ListItem Value="HTML">HTML</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
            <div id="rowGoogleAuth" runat="server" class="row mb-3">
                <asp:Label ID="lblUseMfa" runat="server" meta:resourcekey="lblUseMfa" Text="Use MFA:" AssociatedControlID="cbxMfaEnabled" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                <div class="col-sm-10">
                    <div class="form-check fcp-form-check-stack">
                        <asp:CheckBox id="cbxMfaEnabled" runat="server" AutoPostBack="true" OnCheckedChanged="cbxMfaEnabled_CheckedChanged"></asp:CheckBox>
                        <asp:Label ID="lblMfaEnabled" runat="server" meta:resourcekey="lblMfaEnabled" Text="When you log in, a validation code is sent to the primary email address. Enabling an authentication app stops the validation code from being sent by email." CssClass="fcp-field-note"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="row mb-4">
                <div class="col-sm-10 offset-sm-2">
                    <asp:Button id="btnGetQRCodeData" Visible="false" runat="server" meta:resourcekey="btnGetQRCodeData" Text="Get QR-Code" CssClass="btn btn-outline-primary" OnClick="btnGetQRCodeData_Click"></asp:Button>
                    <div id="qrData" visible="false" runat="server" class="fcp-password-policy mt-3">
                        <asp:Image ID="imgQrCode" runat="server"/>
                        <asp:Label ID="lblManualAuth" runat="server" meta:resourcekey="lblManualAuth" CssClass="d-block mb-2"></asp:Label>
                        <asp:TextBox id="txtQrCodeActivationPin" runat="server" CssClass="form-control mb-2"></asp:TextBox>
                        <asp:Button id="btnActivateQRCode" runat="server" meta:resourcekey="btnActivateQRCode" Text="Validate Activation Pin" CssClass="btn btn-success" OnClick="btnActivateQRCode_Click"></asp:Button>
                    </div>
                </div>
            </div>
        </div>
        <br/>

        <fcp:CollapsiblePanel id="headContact" runat="server" IsCollapsed="true"
            TargetControlID="pnlContact" meta:resourcekey="secContact" Text="Contact">
        </fcp:CollapsiblePanel>
        <asp:Panel ID="pnlContact" runat="server" Height="0" style="overflow:hidden">
            <dnc:usercontact id="contact" runat="server"></dnc:usercontact>
        </asp:Panel>
        <fcp:CollapsiblePanel id="secDisplay" runat="server" IsCollapsed="true"
            TargetControlID="DisplayPanel" meta:resourcekey="secDisplay" Text="Display Preferences">
        </fcp:CollapsiblePanel>
        <asp:Panel ID="DisplayPanel" runat="server" Height="0" style="overflow:hidden">
            <div class="fcp-form-section" id="tblDisplay" runat="server">
                <div class="row mb-3">
                    <asp:Label ID="lblLanguage" runat="server" meta:resourcekey="lblLanguage" Text="Interface Language:" AssociatedControlID="ddlLanguage" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                    <div class="col-sm-10">
                        <asp:DropDownList ID="ddlLanguage" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                </div>
                <div class="row mb-3">
                    <asp:Label ID="lblItemsPerPage" runat="server" meta:resourcekey="lblItemsPerPage" Text="Items Per Page:" AssociatedControlID="txtItemsPerPage" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                    <div class="col-sm-10">
                        <asp:TextBox ID="txtItemsPerPage" runat="server" CssClass="form-control fcp-field-short"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="valRequireGridItems" runat="server" ControlToValidate="txtItemsPerPage" meta:resourcekey="valRequireGridItems" Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="valCorrectGridItems" runat="server" ControlToValidate="txtItemsPerPage" meta:resourcekey="valCorrectGridItems" Display="Dynamic" ErrorMessage="*" ValidationExpression="\d{1,3}"></asp:RegularExpressionValidator>
                    </div>
                </div>
                <div class="row mb-3">
                    <asp:Label ID="lblTheme" runat="server" meta:resourcekey="lblTheme" Text="Theme:" AssociatedControlID="ddlTheme" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                    <div class="col-sm-10">
                        <asp:DropDownList ID="ddlTheme" runat="server" CssClass="form-control" DataValueField="LTRName" DataTextField="DisplayName" AutoPostBack="True" OnSelectedIndexChanged="ddlTheme_SelectedIndexChanged"></asp:DropDownList>
                    </div>
                </div>
                <div class="row mb-3">
                    <asp:Label ID="lblThemeStyle" runat="server" meta:resourcekey="lblThemeStyle" Text="Style:" AssociatedControlID="ddlThemeStyle" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                    <div class="col-sm-10">
                        <asp:DropDownList ID="ddlThemeStyle" runat="server" CssClass="form-control" DataValueField="PropertyValue" DataTextField="PropertyName"></asp:DropDownList>
                    </div>
                </div>
                <div class="row mb-3">
                    <asp:Label ID="lblThemecolorHeader" runat="server" meta:resourcekey="lblThemecolorHeader" Text="Header Color:" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                    <div class="col-sm-10">
                        <asp:panel runat="server" CssClass="row row-cols-auto g-3">
                            <asp:Repeater ID="ThemecolorHeaderRepeater1" runat="server">
                                <ItemTemplate>
                                    <asp:panel ID="ThemecolorHeaderPanel" runat="server" Height="45" BorderWidth="10" BorderColor="Transparent" CssClass="col">
                                        <asp:button ID="ThemecolorHeaderButton" runat="server" BorderWidth="0" Height="40" BackColor='<%# ConvertFromHexToColor( Eval("PropertyName").ToString() )%>' oncommand='ThemecolorHeader_Click' CommandArgument='<%# Eval("PropertyValue").ToString()%>' CssClass="indigator" />
                                    </asp:panel>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:panel>
                    </div>
                </div>
                <div class="row mb-4">
                    <asp:Label ID="lblThemecolorSidebar" runat="server" meta:resourcekey="lblThemecolorSidebar" Text="Sidebar Color:" CssClass="col-sm-2 col-form-label fcp-form-label"></asp:Label>
                    <div class="col-sm-10">
                        <asp:panel runat="server" CssClass="row row-cols-auto g-3">
                            <asp:Repeater ID="ThemecolorSidebarRepeater1" runat="server">
                                <ItemTemplate>
                                    <asp:panel ID="ThemecolorSidebarPanel" runat="server" Height="45" BorderWidth="10" BorderColor="Transparent" CssClass="col">
                                        <asp:button ID="ThemecolorSidebarButton" runat="server" BorderWidth="0" Height="40" BackColor='<%# ConvertFromHexToColor( Eval("PropertyName").ToString() )%>' oncommand='ThemecolorSidebar_Click' CommandArgument='<%# Eval("PropertyValue").ToString()%>' CssClass="indigator" />
                                    </asp:panel>
                                </ItemTemplate>
                            </asp:Repeater>
                        </asp:panel>
                    </div>
                </div>
                <div class="row mb-0">
                    <div class="col-sm-10 offset-sm-2">
                        <asp:Button id="ResetDisplay" runat="server" meta:resourcekey="cmdResetDisplay" Text="Reset Display Settings" CssClass="btn btn-outline-secondary" OnClick="cmdResetDisplay_Click"></asp:Button>
                    </div>
                </div>
            </div>
        </asp:Panel>
</div>
<div class="card-footer text-end">
    <asp:LinkButton id="btnUpdate" CssClass="btn btn-success" runat="server" OnClick="btnUpdate_Click"> <i class="bi bi-arrow-clockwise">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnUpdate"/>  </asp:LinkButton>
</div>
</asp:Panel>

