<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="WebSitesHomeFolderControl.ascx.cs" Inherits="FuseCP.Portal.WebSitesHomeFolderControl" %>
<%@ Register Src="UserControls/FileLookup.ascx" TagName="FileLookup" TagPrefix="uc1" %>
<div class="p-3">
<table class="w-100">
	<tr>
		<td class="NormalBold" colspan="2"><asp:radiobutton id="rbLocationFolder" meta:resourcekey="rbLocationFolder" GroupName="Content" AutoPostBack="True" Text="Directory in your home folder"
				Runat="server" Checked="True" OnCheckedChanged="rbLocationFolder_CheckedChanged"></asp:radiobutton></td>
	</tr>
	<tr>
		<td class="NormalBold" colspan="2"><asp:radiobutton id="rbLocationRedirect" meta:resourcekey="rbLocationRedirect" GroupName="Content" AutoPostBack="True" Text="Redirection to URL"
				Runat="server" OnCheckedChanged="rbLocationRedirect_CheckedChanged"></asp:radiobutton></td>
	</tr>
	<tr>
	    <td style="width: 30px;"></td>
	    <td>
	        <table id="tblFolder" runat="server">
	            <tr>
	                <td colspan="3">
			            <table class="w-100">
				            <tr>
				            <td class="Normal text-nowrap align-top" style="padding-top:7px;">
					                <asp:Label ID="lblSitePath" runat="server" meta:resourcekey="lblSitePath" Text="Path:"></asp:Label>
					            </td>
				            <td class="align-top">
                                    <uc1:FileLookup ID="fileLookup" runat="server" Width="300" />
                                </td>
				            </tr>
			            </table>     
	                </td>
	            </tr>
	            <tr>
	                <td colspan="3" class="Normal">&nbsp;</td>
	            </tr>
	            <tr>
	                <td class="Normal align-top">
			            <table class="Normal">
			                <tr>
			                    <td class="NormalBold">
			                        <asp:Label ID="lblSecuritySettings" runat="server" meta:resourcekey="lblSecuritySettings" Text="Security Settings:"></asp:Label>
			                    </td>
			                </tr>
				            <tr>
					            <td><asp:checkbox id="chkWrite" meta:resourcekey="chkAllowWrite" Text="Write" Runat="server"></asp:checkbox></td>
				            </tr>
				            <tr>
					            <td><asp:checkbox id="chkDirectoryBrowsing" meta:resourcekey="chkAllowDirectoryBrowsing" Text="Directory browsing" Runat="server"></asp:checkbox></td>
				            </tr>
				            <tr>
					            <td><asp:checkbox id="chkParentPaths" meta:resourcekey="chkParentPaths" Text="Enabled Parent Paths" Runat="server"></asp:checkbox></td>
				            </tr>
				            <tr id="rowDedicatedPool" runat="server">
					            <td><asp:checkbox id="chkDedicatedPool" meta:resourcekey="chkDedicatedPool" Text="Dedicated Application Pool" Runat="server"></asp:checkbox></td>
				            </tr>
			            </table>

			            <asp:PlaceHolder runat="server" id="pnlCustomAuth">
			            <br />
			            <table class="Normal">
			                <tr>
			                    <td class="NormalBold">
			                        <asp:Label ID="lblAuthentication" runat="server" meta:resourcekey="lblAuthentication" Text="Authentication:"></asp:Label>
			                    </td>
			                </tr>
							<tr>
	                            <td class="text-nowrap"><asp:checkbox id="chkAuthAnonymous" meta:resourcekey="chkAuthAnonymous" Text="Enable anonymous access" Runat="server"></asp:checkbox></td>
                            </tr>
                            <tr>
	                            <td class="text-nowrap"><asp:checkbox id="chkAuthWindows" meta:resourcekey="chkAuthWindows" Text="Integrated Windows authentication" Runat="server"></asp:checkbox></td>
                            </tr>
                            <tr>
	                            <td class="text-nowrap"><asp:checkbox id="chkAuthBasic" meta:resourcekey="chkAuthBasic" Text="Basic authentication" Runat="server"></asp:checkbox></td>
                            </tr>
                            
                        </table>
			            </asp:PlaceHolder>

                            
						<table class="Normal">
                            <tr>
			                    <td class="NormalBold">
			                        <asp:Label ID="lblCompression" runat="server" meta:resourcekey="lblCompression" Text="Compression:"></asp:Label>
			                    </td>
			                </tr>
                            <tr>
	                            <td class="text-nowrap"><asp:checkbox id="chkDynamicCompression" meta:resourcekey="chkDynamicCompression" Text="Enable dynamic compression" Runat="server"></asp:checkbox></td>
                            </tr>
                            <tr>
	                            <td class="text-nowrap"><asp:checkbox id="chkStaticCompression" meta:resourcekey="chkStaticCompression" Text="Enable static compression" Runat="server"></asp:checkbox></td>
                            </tr>
                        </table>

	                </td>
	                <td style="width: 30px;"></td>
	                <td class="align-top">
	                    <asp:PlaceHolder runat="server" id="pnlDefaultDocuments">
	                    <table>
	                        <tr>
			                    <td class="NormalBold">
			                        <asp:Label ID="lblDefaultDocuments" runat="server" meta:resourcekey="lblDefaultDocuments" Text="Default Documents:"></asp:Label>
			                    </td>
	                        </tr>
	                        <tr>
	                            <td>
	                                <asp:TextBox ID="txtDefaultDocs" runat="server" TextMode="MultiLine"
	                                    Rows="7" CssClass="form-control" Width="200px"></asp:TextBox>
	                            </td>
	                        </tr>
	                    </table>
	                    </asp:PlaceHolder>
	                </td>
	            </tr>
	        </table>
	        <table id="tblRedirect" runat="server">
	            <tr>
		            <td class="Normal">
		                
		                <table class="w-100">
				            <tr>
				                <td>
		                            <asp:textbox id="txtRedirectUrl" Runat="server" CssClass="form-control" Width="300px"></asp:textbox>
			                        <asp:requiredfieldvalidator id="valRedirection" CssClass="NormalBold" ControlToValidate="txtRedirectUrl" Display="Dynamic"
				                            ErrorMessage="Please enter the redirection URL" runat="server"></asp:requiredfieldvalidator>
				                </td>
				            </tr>
				            <tr>
				                <td>
				                    <table class="Normal">
				                        <tr>
					                        <td><asp:checkbox id="chkRedirectExactUrl" Text="The exact URL entered above" Runat="server"></asp:checkbox></td>
				                        </tr>
				                        <tr>
					                        <td><asp:checkbox id="chkRedirectDirectoryBelow" Text="A directory below URL entered" Runat="server"></asp:checkbox></td>
				                        </tr>
				                        <tr>
					                        <td><asp:checkbox id="chkRedirectPermanent" Text="A permanent redirection to this resource" Runat="server"></asp:checkbox></td>
				                        </tr>
			                        </table>
				                </td>
				            </tr>
				        </table>
				    </td>
	            </tr>
	        </table>
	    </td>
	</tr>
</table>
</div>
