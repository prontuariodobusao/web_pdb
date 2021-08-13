import {GetStorage} from '../../../domain/protocols/cache'

export class LocalStorageAdapter implements GetStorage {
  get(key: string): any {
    return JSON.parse(localStorage.getItem(key) as string)
  }
}
