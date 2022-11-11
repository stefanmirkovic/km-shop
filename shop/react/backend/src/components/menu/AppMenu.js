import * as React from 'react';
import {useContext} from 'react';
import PropTypes from "prop-types";
import {NavigateContext} from "../../base";
import {StyledMenuList} from "./styled/StyledMenuList";
import {MenuItemGroup} from "./elements/MenuItemGroup";
import {MenuItem} from "./elements/MenuItem";
import {MenuDriver} from "./elements/MenuDriver";

/**
 * Application menu admin panel
 */
export function AppMenu(props) {

    const {
        configuration = []
    } = props

    const {route} = useContext(NavigateContext)

    const listElements = []

    configuration.map((item) => {
        if (item.links) {
            item["selected"] = route.isPages(item.links)
        }
        if (item.children) {
            item.children.map((item) => {
                if (item.links) {
                    item["selected"] = route.isPages(item.links)
                }
                return item
            })
        }
        return item
    })

    configuration.forEach((item, index) => {
        if (item.type === 'driver') {
            listElements.push(
                <MenuDriver
                    icon={item.icon}
                    title={item.title}
                    key={`menu-item-driver-${index}`}
                />
            )
        } else {
            listElements.push(item.group ? (
                <MenuItemGroup
                    icon={item.icon}
                    group={item.group}
                    children={item.children}
                    key={`menu-item-group-${index}`}
                />
            ) : (
                <MenuItem
                    link={item.link}
                    icon={item.icon}
                    title={item.title}
                    selected={item.selected === true}
                    key={`menu-item-${index}`}
                />
            ))
        }
    })

    return (
        <StyledMenuList>
            {listElements}
        </StyledMenuList>
    );
}

AppMenu.propTypes = {
    configuration: PropTypes.array.isRequired,
};

