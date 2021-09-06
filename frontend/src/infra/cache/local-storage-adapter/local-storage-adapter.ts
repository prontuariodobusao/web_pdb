import {GetStorage, SetStorage} from '../../../domain/protocols/cache'

export class LocalStorageAdapter implements GetStorage, SetStorage {
  // eslint-disable-next-line @typescript-eslint/explicit-module-boundary-types
  set(key: string, value: any): void {
    if (value) {
      localStorage.setItem(key, JSON.stringify(value))
    } else {
      localStorage.removeItem(key)
    }
  }
  get(key: string): any {
    return JSON.parse(localStorage.getItem(key) as string)
  }
}
