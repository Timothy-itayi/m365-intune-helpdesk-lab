# 3.3 Find the Licence SKU

Previous: [00-connect-mggraph.md](00-connect-mggraph.md)

## Steps

```powershell
Get-MgSubscribedSku | Select SkuPartNumber, ConsumedUnits, @{n='Total';e={$_.PrepaidUnits.Enabled}}
```

Expected: a table. Business Premium usually shows `SPB`. If yours differs, pass that value with `-LicenseSku`.

## Evidence

![Licence SKU list](images/licence-sku.png)

| SkuPartNumber | ConsumedUnits | Total |
| --- | --- | --- |
| `SPB` | 7 | 25 |

`SPB` is Microsoft 365 Business Premium, and it matches the script's default `-LicenseSku`, so no override was needed.

The 7 consumed licences fit the earlier evidence. Before the starters, the licence page showed 1 of 25 assigned to the admin ([02-check-licences.md](../01-tenant/02-check-licences.md)). Six starters add 6, giving 7. The Active users page ([04-verify-portals.md](04-verify-portals.md)) shows five of the six starters licensed, so this count is the only evidence covering the sixth, Farid Haddad. The break-glass account is unlicensed, so it does not add to the count.
