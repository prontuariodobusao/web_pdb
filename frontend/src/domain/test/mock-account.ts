import {Account} from '../../main/adapters'
import faker from 'faker'

export const mockAccountModel = (): Account => ({
  accessToken: faker.datatype.uuid(),
  name: faker.name.findName(),
  role: faker.name.findName(),
  confirmation: true,
})
