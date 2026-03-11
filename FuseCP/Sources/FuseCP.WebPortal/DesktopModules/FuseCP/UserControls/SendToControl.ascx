<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SendToControl.ascx.cs" Inherits="FuseCP.Portal.UserControls.SendToControl" %>
<div>
    <div>
        <fieldset>
                <div class="row mb-3">
                    <div class="col-sm-10 offset-sm-2">
                        <div id="SendPasswordResetEmailDiv" class="input-group" runat="server">
                            <asp:CheckBox ID="chkSendPasswordResetEmail" runat="server" AutoPostBack="true" OnCheckedChanged="chkSendPasswordResetEmail_StateChanged" />
                            <asp:Label runat="server" AssociatedControlID="chkSendPasswordResetEmail" CssClass="text-nowrap">
                                <asp:Localize ID="Localize1" runat="server" meta:resourcekey="chkSendPasswordResetEmailLabel" Text="Send Password Request." />
                            </asp:Label>
                        </div>
                    </div>
                </div>
        </fieldset>
    </div>
</div>
<div id="SendToBody" runat="server" visible="False">
        <fieldset>
                <div class="col-md-12">
                    <div class="mb-3 d-flex flex-wrap gap-2 align-items-center">
                        <label for="locSendTo" class="col-sm-2 form-label">
                            <asp:Localize ID="locSendTo" runat="server" meta:resourcekey="locSendTo" Text="Send to:" />
                        </label> 
						<div class="col-sm-10">
                            <div class="input-group d-flex flex-wrap gap-2 align-items-center">
                                <div class="FormRBtnL">
                                    <label class="input-group-text">
                                        <i class="bi bi-envelope" aria-hidden="true"></i>
                                        <asp:RadioButton ID="rbtnEmail" runat="server" meta:resourcekey="rbtnEmail" Text="Email" GroupName="SendToGroup" AutoPostBack="true" Checked="true" OnCheckedChanged="SendToGroupCheckedChanged" />
                                    </label>
                                    <asp:label ID="rbtnMobileLabel" runat="server" CssClass="input-group-text">
                                        <i class="bi bi-mobile" aria-hidden="true"></i>
                                        <asp:RadioButton ID="rbtnMobile" runat="server" meta:resourcekey="rbtnMobile" Text="Mobile" GroupName="SendToGroup" AutoPostBack="true" OnCheckedChanged="SendToGroupCheckedChanged" />
                                    </asp:label>
                                </div>
                    </div>
                </div>
            </div>
                    </div>
                <div id="EmailDiv" runat="server" class="col-md-12">
                    <div class="mb-3 d-flex flex-wrap gap-2 align-items-center">
                        <label for="txtEmailAddress" class="col-sm-2 form-label">
                            <asp:Localize ID="locEmailAddress" runat="server" meta:resourcekey="locEmailAddress" />
                        </label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-envelope" aria-hidden="true"></i></span>
                                <asp:TextBox runat="server" ID="txtEmailAddress" CssClass="form-control" placeholder="Email Address" />
                            </div>
                            <asp:RequiredFieldValidator ID="valEmailAddress" runat="server" ErrorMessage="*" ControlToValidate="txtEmailAddress" ValidationGroup="ResetUserPassword"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="regexEmailValid" runat="server" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="ResetUserPassword" ControlToValidate="txtEmailAddress" ErrorMessage="Invalid Email Format"></asp:RegularExpressionValidator>
                        </div>
                </div>
            </div>
                <div id="MobileDiv" runat="server" class="col-md-12">
                    <div class="mb-3 d-flex flex-wrap gap-2 align-items-center">
                        <label for="txtMobile" class="col-sm-2 form-label">
                            <asp:Localize ID="locMobile" runat="server" meta:resourcekey="locMobile" />
                        </label>
                        <div class="col-sm-10">
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-mobile" aria-hidden="true"></i></span>
                                <asp:TextBox runat="server" ID="txtMobile" CssClass="form-control col-md-4" placeholder="Cell Phone" />
                            </div>
                            <asp:RequiredFieldValidator ID="valMobile" runat="server" ErrorMessage="*" ControlToValidate="txtMobile" ValidationGroup="ResetUserPassword"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="regexMobileValid" runat="server" ValidationExpression="^\+?\d+$" ValidationGroup="ResetUserPassword" ControlToValidate="txtMobile" ErrorMessage="Invalid Mobile Format"></asp:RegularExpressionValidator>
                        </div>
                    </div>
                </div>
        </fieldset>
    </div>
