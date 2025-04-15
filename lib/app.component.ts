import { importProvidersFrom } from "@angular/core";
import { ApplicationConfig } from "@angular/platform-browser";
import { environment } from "src/environments/environment.development";
import { initializeApp, provideFirebaseApp } fron "@angular/fire/app";
import { getFirestore, provideFirestore} from "@angular/fire/firestore";


const appConfig: ApplicationConfig = {
    providers: [
        importProvidersFrom(
            provideFirebaseApp(() => initializeApp(environment.firebase)),
            provideFirestore(() => getFirestore())
        )
    ]
};

export class AppComponent {
    private readonly firestore: Firestore = inject(Firestore);
}