import {LocalStorageAdapter} from './local-storage-adapter'

import 'jest-localstorage-mock'
import faker from 'faker'

const makeSut = (): LocalStorageAdapter => new LocalStorageAdapter()

describe('AsyncStorageAdapter', () => {
  beforeEach(() => {
    localStorage.clear()
  })

  it('Should call AsyncStorage.getItem with correct value', async () => {
    const sut = makeSut()
    const key = faker.database.column()
    const value: any = faker.random.objectElement<any>()
    const getItemSpy = jest
      .spyOn(localStorage, 'getItem')
      .mockReturnValueOnce(value)

    const obj = await sut.get(key)

    expect(obj).toEqual(value)
    expect(getItemSpy).toHaveBeenCalledWith(key)
  })
})
