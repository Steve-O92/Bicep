targetScope = 'subscription'


param environments array = [
  'production'
  'test'
  'dev'
  'acceptance'
]

param costcenter array = [
  'kgg'
  'giantict'
  'hr'
  'tekenkamer'
]

resource requireTagOnResourceGroups 'Microsoft.Authorization/policyDefinitions@2021-06-01' = {
  name: 'requireTagOnResourceGroups'
  properties: {
    policyType: 'Custom'
    mode: 'All'
    displayName: 'Require specific tags on resource groups'
    description: 'This policy requires specific tags on all resource groups.'
    policyRule: {
      if: {
        anyOf: [
          {
            field: 'tags.environment'
            exists: 'false'
          }
          {
            field: 'tags.costcenter'
            exists: 'false'
          }
          {
            field: 'tags.creator'
            exists: 'false'
          }
          {
            field: 'tags.location'
            exists: 'false'
          }
          {
            allOf: [
              {
                field: 'tags.environment'
                exists: 'true'
              }
              {
                not: {
                  field: 'tags.environment'
                  in: environments
                }
              }
            ]
          }
          {
            allOf: [
              {
                field: 'tags.costcenter'
                exists: 'true'
              }
              {
                not: {
                  field: 'tags.costcenter'
                  in: costcenter
                }
              }
            ]
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

resource tagPolicyInitiative 'Microsoft.Authorization/policySetDefinitions@2021-06-01' = {
  name: 'GiantICTTaggingPolicy'
  properties: {
    policyType: 'Custom'
    displayName: 'Giant ICT Tagging Policy'
    description: 'This initiative enforces the tag policies on the subscription.'
    policyDefinitions: [
      {
       policyDefinitionId: requireTagOnResourceGroups.id
      }
    ]
  }
}

resource policyAssignment 'Microsoft.Authorization/policyAssignments@2021-06-01' = {
  name: 'policyAssignment'
  properties: {
    displayName: 'Giant - Enforce Tag Policies'
    description: 'This assignment enforces the tag policies on the subscription.'
    policyDefinitionId: tagPolicyInitiative.id
  }
}
