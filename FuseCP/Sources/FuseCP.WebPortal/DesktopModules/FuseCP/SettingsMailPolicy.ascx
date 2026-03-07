<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SettingsMailPolicy.ascx.cs" Inherits="FuseCP.Portal.SettingsMailPolicy" %>
<%@ Register Src="UserControls/UsernamePolicyEditor.ascx" TagName="UsernamePolicyEditor" TagPrefix="uc2" %>
<%@ Register Src="UserControls/PasswordPolicyEditor.ascx" TagName="PasswordPolicyEditor" TagPrefix="uc1" %>
<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="UserControls/CollapsiblePanel.ascx" %>

<fcp:CollapsiblePanel id="secGeneral" runat="server"
    TargetControlID="GeneralPanel" meta:resourcekey="secGeneral" Text="General Settings"/>
<asp:Panel ID="GeneralPanel" runat="server" Height="0" style="overflow:hidden">
    <table class="table table-borderless align-middle mb-0">
        <tr>
            <td class="SubHead text-nowrap align-top">
                <asp:Label ID="lblCatchAll" runat="server" meta:resourcekey="lblCatchAll" Text="Catch-All Account:"></asp:Label>
            </td>
            <td class="Normal">
                <asp:TextBox ID="txtCatchAll" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="valRequireCatchAll" runat="server" ControlToValidate="txtCatchAll" meta:resourcekey="valRequireCatchAll"
                    Display="Dynamic" ErrorMessage="*" ValidationGroup="SettingsEditor"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
</asp:Panel>

<fcp:CollapsiblePanel id="secAccountPolicy" runat="server"
    TargetControlID="AccountPolicyPanel" meta:resourcekey="secAccountPolicy" Text="Mail Accounts Policy"/>
<asp:Panel ID="AccountPolicyPanel" runat="server" Height="0" style="overflow:hidden">
    <table class="table table-borderless align-middle mb-0">
        <tr>
            <td class="SubHead text-nowrap align-top">
                <asp:Label ID="lblAccount" runat="server" meta:resourcekey="lblAccount" Text="Account Policy:"></asp:Label>
            </td>
            <td class="Normal">
                <uc2:UsernamePolicyEditor id="accountNamePolicy" runat="server">
                </uc2:UsernamePolicyEditor></td>
        </tr>
        <tr>
            <td class="SubHead align-top">
                <asp:Label ID="lblPassword" runat="server" meta:resourcekey="lblPassword" Text="Password Policy:"></asp:Label>
            </td>
            <td class="Normal">
                <uc1:PasswordPolicyEditor id="accountPasswordPolicy" runat="server">
                </uc1:PasswordPolicyEditor></td>
        </tr>
    </table>
</asp:Panel>

<fcp:CollapsiblePanel id="secAccessPolicy" runat="server"
    TargetControlID="AccessPolicyPanel" meta:resourcekey="secAccessPolicy" Text="Mail Access Policy"/>
<asp:Panel ID="AccessPolicyPanel" runat="server" Height="0" style="overflow:hidden">
    <table class="table table-borderless align-middle mb-0">
        <tr>
            <asp:Label ID="lblAccessPolicyNote" meta:resourcekey="lblAccessPolicyNote" Text="These settings only apply to the SmarterMail100 provider" runat="server" />
        </tr>
        <tr>
            <td><asp:Label ID="lblAuthType" meta:resourcekey="lblAuthType" Text="Countries To Block:" runat="server" /></td>
            <td>
                <asp:DropDownList ID="ddlAuthType" runat="server">
                    <asp:ListItem Value="1" meta:resourcekey="ddlAuthType1">Specified Countries</asp:ListItem>
                    <asp:ListItem Value="2" meta:resourcekey="ddlAuthType2">All But Specified Countries</asp:ListItem>
                </asp:DropDownList>
        </td>
        </tr>
            <tr>
        <td class="align-top">
            <asp:Localize ID="Localize1" runat="server" meta:resourcekey="lblCountry" Text="Add Country:" />
        </td>
        <td class="Normal">
            <asp:DropDownList ID="ddlAddCountry" runat="server"> </asp:DropDownList>
            <asp:Button ID="btnAddCountry" runat="server" Text="Add Country" OnClick="btnAddCountry_Click" meta:resourcekey="btnAddCountry" CssClass="btn btn-success" />
        </td>
    </tr>
    <tr>
        <td class="align-top">
            <asp:Localize ID="Localize2" runat="server" meta:resourcekey="lblSelectedCountries" Text="Selected Countries:" />
        </td>
        <td class="Normal">
            <asp:GridView ID="gvSelectedCountries" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Name" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            &nbsp&nbsp<asp:LinkButton ID="btnRemove" runat="server" CssClass="btn btn-danger" CommandArgument='<%# Eval("Code") %>' OnClick="btnRemove_Click" >
                                &nbsp<i class="bi bi-trash"></i>&nbsp; 
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </td>
    </tr>
    </table>
</asp:Panel>

