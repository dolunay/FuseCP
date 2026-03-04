// Copyright (C) 2025 FuseCP
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

using System;
using System.Net;
using System.Text.Encodings.Web;
using System.Text.RegularExpressions;
#if NET48
using Microsoft.Security.Application;
#endif

//usage
//<%@ Import Namespace="FuseCP.Portal" %>
//using FuseCP.Portal;

namespace FuseCP.Portal
{
    public class PortalAntiXSS
    {
        public static string CheckExchangeRecipientName(string input)
        {
            Regex pattern = new Regex("['\"]");
            return pattern.Replace(input, "");
        }

        public static string Encode(string input)
        {
#if NET48
            return Encoder.HtmlEncode(input);
#else
            return input == null ? null : HtmlEncoder.Default.Encode(input);
#endif
        }

        public static string EncodeOld(string input)
        {
            return Encode(DecodeOld(input)); // HtmlDecode is used for compatability reasons with FCP pre-1.2.2 versions
        }

        public static string DecodeOld(string input)
        {
            return WebUtility.HtmlDecode(input); // HtmlDecode is used for compatability reasons with FCP pre-1.2.2 versions
        }
        
    }
}
