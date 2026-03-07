<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AllocatePackageVLANs.ascx.cs" Inherits="FuseCP.Portal.UserControls.AllocatePackageVLANs" %>
<%@ Register Src="SimpleMessageBox.ascx" TagName="SimpleMessageBox" TagPrefix="fcp" %>


<fcp:SimpleMessageBox id="messageBox" runat="server" />

<asp:ValidationSummary ID="validatorsSummary" runat="server" 
    ValidationGroup="AddVLAN" ShowMessageBox="True" ShowSummary="False" />
 
<ul id="ErrorMessagesList" runat="server" visible="false">
    <li id="EmptyVLANsMessage" runat="server">
        <asp:Localize ID="locNotEnougVLANs" runat="server" Text="Not enough..." meta:resourcekey="locNotEnoughVLANs"></asp:Localize>
    </li>
    <li id="QuotaReachedMessage" runat="server">
        <asp:Localize ID="locQuotaReached" runat="server" Text="Quota reached..." meta:resourcekey="locQuotaReached"></asp:Localize>
    </li>
</ul>

 <asp:UpdatePanel runat="server" ID="VLANsTable" UpdateMode="Conditional">
     <ContentTemplate>
        <table >
            <tr>
                <td>
                    <asp:RadioButton ID="radioVLANRandom" runat="server" AutoPostBack="true"
                        meta:resourcekey="radioVLANRandom" Text="Randomly select VLANs from the pool" 
                        Checked="True" GroupName="VLAN" 
                        oncheckedchanged="radioVLANRandom_CheckedChanged" />
                </td>
            </tr>
            <tr id="VLANsNumberRow" runat="server">
                <td style="padding-left: 30px">
                    <asp:Localize ID="locVLANs" runat="server"
                            meta:resourcekey="locVLANs" Text="Number of VLANs:"></asp:Localize>

                    <asp:TextBox ID="txtVLANsNumber" runat="server" CssClass="form-control"></asp:TextBox>
                    
                    <asp:RequiredFieldValidator ID="VLANsValidator" runat="server" Text="*" Display="Dynamic"
                            ControlToValidate="txtVLANsNumber" meta:resourcekey="VLANsValidator" SetFocusOnError="true"
                            ValidationGroup="AddVLAN">*</asp:RequiredFieldValidator>
                            
                    <asp:Literal ID="litMaxVLANs" runat="server"></asp:Literal>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:RadioButton ID="radioVLANSelected" runat="server" AutoPostBack="true"
                        meta:resourcekey="radioVLANSelected" Text="Select VLANs from the list" 
                        GroupName="VLAN" 
                        oncheckedchanged="radioVLANSelected_CheckedChanged" />
                </td>
            </tr>
            <tr id="VLANsListRow" runat="server">
                <td style="padding-left: 30px">
                    <asp:ListBox ID="listVLANs" SelectionMode="Multiple" runat="server" Rows="8"
                        CssClass="form-control" style="height:100px" ></asp:ListBox>
                    <br />
                    <asp:Localize ID="locHoldCtrl" runat="server" 
                            meta:resourcekey="locHoldCtrl" Text="* Hold CTRL key to select multiple addresses" ></asp:Localize>
                </td>
            </tr>
        </table>
    </ContentTemplate>
</asp:UpdatePanel>
<p style="text-align:right">
    <asp:LinkButton id="btnCancel" CssClass="btn btn-warning" runat="server" CausesValidation="False" OnClick="btnCancel_Click"> <i class="bi bi-x-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnCancel"/> </asp:LinkButton>&nbsp;
    <asp:LinkButton id="btnAdd" CssClass="btn btn-success" runat="server" OnClick="btnAdd_Click" ValidationGroup="AddVLAN"> <i class="bi bi-check-lg">&nbsp;</i>&nbsp;<asp:Localize runat="server" meta:resourcekey="btnAdd"/> </asp:LinkButton>
</p>
