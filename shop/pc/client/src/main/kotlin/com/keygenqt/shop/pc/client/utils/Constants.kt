/*
 * Copyright 2023 Vitaliy Zarubin
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.keygenqt.shop.pc.client.utils

import com.keygenqt.shop.utils.constants.AppConstants
import com.typesafe.config.Config
import com.typesafe.config.ConfigFactory
import java.io.File

object Constants {
    /**
     * D-Bus service name
     */
    const val SERVICE_DBUS_APP = "com.keygenqt.ShopDBus.PC.app"
    const val SERVICE_DBUS_CLIENT = "com.keygenqt.ShopDBus.PC.client"

    /**
     * Path cookie file
     */
    val PATH_COOKIE_FILE = System.getProperty("user.home") +
        File.separator +
        ".shop_client_cookie.json"

    /**
     * Secret cookie file
     */
    const val SECRET_COOKIE_FILE = "fkHiPpAALpni1GLR4dGu"

    /**
     * Get domain
     */
    val IS_DEVELOPMENT by lazy {
        val conf: Config = ConfigFactory.load()
        conf.getBoolean("config.development")
    }

    /**
     * Get domain
     */
    val GET_DOMAIN by lazy {
        (if (IS_DEVELOPMENT) AppConstants.links.API_DEBUG_URL else AppConstants.links.API_URL)
            .trim('/').substringAfterLast("/").substringBefore(":")
    }
}
