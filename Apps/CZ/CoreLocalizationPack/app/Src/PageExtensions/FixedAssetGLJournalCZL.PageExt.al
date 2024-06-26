﻿// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.FixedAssets.Journal;

using Microsoft.Finance.VAT.Calculation;

pageextension 31212 "Fixed Asset G/L Journal CZL" extends "Fixed Asset G/L Journal"
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Reporting Date CZL"; Rec."VAT Reporting Date")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the date used to include entries on VAT reports in a VAT period. This is either the date that the document was created or posted, depending on your setting on the General Ledger Setup page.';
                Visible = VATDateEnabled;
            }
            field("Original Doc. VAT Date CZL"; Rec."Original Doc. VAT Date CZL")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the VAT date of the original document.';
                Visible = false;
            }
        }
        addafter("Account No.")
        {
            field("Posting Group CZL"; Rec."Posting Group")
            {
                ApplicationArea = Suite;
                ToolTip = 'Specifies the posting group that will be used in posting the journal line.The field is used only if the account type is either customer or vendor.';
                Visible = false;
            }
        }
        addbefore(Amount)
        {
            field("Correction CZL"; Rec.Correction)
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the entry as a corrective entry. You can use the field if you need to post a corrective entry to an account.';
                Visible = false;
            }
        }
        addafter(Amount)
        {
            field("Amount (LCY) CZL"; Rec."Amount (LCY)")
            {
                ApplicationArea = FixedAssets;
                ToolTip = 'Specifies the total amount that the journal line consists of.';
            }
        }
    }
    trigger OnOpenPage()
    begin
        VATDateEnabled := VATReportingDateMgt.IsVATDateEnabled();
    end;

    var
        VATReportingDateMgt: Codeunit "VAT Reporting Date Mgt";
        VATDateEnabled: Boolean;
}
