<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SmarterMail100x_EditAccess.ascx.cs" Inherits="FuseCP.Portal.ProviderControls.SmarterMail100x_EditAccess" %>

<%@ Register Src="../UserControls/QuotaEditor.ascx" TagName="QuotaEditor" TagPrefix="uc1" %>
<%@ Register TagPrefix="fcp" TagName="CollapsiblePanel" Src="../UserControls/CollapsiblePanel.ascx" %>

<table>
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
