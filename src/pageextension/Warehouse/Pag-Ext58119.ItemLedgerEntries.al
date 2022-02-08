/// <summary>
/// PageExtension "ItemLedgerEntries" (ID 58119) extends Record Item Ledger Entries.
/// </summary>
pageextension 58119 ItemLedgerEntries extends "Item Ledger Entries"
{
    layout
    {
        addafter("Item No.")
        {
            field("Part No."; rec."Part No.")
            {
                ApplicationArea = all;
            }

        }

    }
}
